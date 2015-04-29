# == Schema Information
#
# Table name: showcase_tasks
#
#  id                   :integer          not null, primary key
#  cron                 :string(255)
#  content_limit        :integer
#  last_timestamp       :datetime
#  last_timestamp_epoch :integer
#  created_at           :datetime
#  updated_at           :datetime
#  last_rank            :integer
#

class ShowcaseTask < ActiveRecord::Base

  def self.populate_performances

     performance_maps = []
     # last_rank=1;
     rank=1
  	 ShowcaseQueue.where(is_deleted:false).order(total_appreciations: :desc).each do |queue_data|
        performance_map ={}
        performance_map[:showcase_id]=queue_data.showcase_id
        performance_map[:showcase_title]=queue_data.title
        performance_map[:showcase_media_type]=queue_data.media_type
        performance_map[:showcase_total_appreciations]=ResponseMap.where(showcase_id:queue_data.showcase, has_appreciated:true).size()
        performance_map[:showcase_total_skips]=ResponseMap.where(showcase_id:queue_data.showcase, has_skipped:true).size()
        performance_map[:showcase_created_at]=queue_data.showcase.created_at
        performance_map[:showcase_rank]=rank
        performance_map[:showcase_top_rank]=rank
        performance_map[:is_showcase_copyrighted]=false
        # performance_map[:last_rank]=last_rank
        performance_map[:showcase_score]=0.0 #ideally should be wilson score
        performance_maps.push(performance_map)

        queue_data.showcase.user.update(has_posted:false)
        RankMap.create_or_update(queue_data.showcase.user_id,rank)
        rank+=1
        # last_rank+=1
  	 end

  	 Performance.all.order(:showcase_rank).each do |performance|
  	 	performance_map ={}
            performance_map[:showcase_id]=performance.showcase_id
            performance_map[:showcase_title]=performance.showcase_title
            performance_map[:showcase_media_type]=performance.showcase_media_type
            performance_map[:showcase_total_appreciations]=performance.showcase_total_appreciations
            performance_map[:showcase_total_skips]=performance.showcase_total_skips
            performance_map[:showcase_created_at]= performance.showcase_created_at
            performance_map[:showcase_top_rank]=performance.showcase_top_rank
            # performance_map[:last_rank]=performance.showcase_rank
            performance_map[:showcase_rank]=rank
            performance_map[:is_showcase_copyrighted]=true
            performance_map[:showcase_score]=performance.showcase_score #ideally should be wilson score
            performance_maps.push(performance_map)
            rank+=1
  	 end
  	 Performance.delete_all

  	 performance_maps.each do |performance_map|
  	 	performance=Performance.create!(showcase_id:performance_map[:showcase_id],
        				   showcase_title:performance_map[:showcase_title],
        				   showcase_media_type:performance_map[:showcase_media_type],
        				   showcase_total_appreciations:performance_map[:showcase_total_appreciations],
        				   showcase_total_skips:performance_map[:showcase_total_skips],
        				   showcase_created_at:performance_map[:showcase_created_at],
        				   showcase_rank:performance_map[:showcase_rank],
        				   showcase_score:performance_map[:showcase_score],
                   is_showcase_copyrighted:performance_map[:is_showcase_copyrighted],
                              # last_rank:performance_map[:last_rank],
                   showcase_top_rank:performance_map[:showcase_top_rank])

  	 end
     ShowcaseQueue.delete_all
     ShowcaseCap.update_showcase_cap

  end

end
