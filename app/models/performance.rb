# == Schema Information
#
# Table name: performances
#
#  id                           :integer          not null, primary key
#  showcase_id                  :integer
#  showcase_title               :string(255)
#  showcase_media_type          :integer
#  showcase_total_appreciations :integer
#  showcase_total_skips         :integer
#  showcase_created_at          :datetime
#  showcase_rank                :integer
#  showcase_score               :decimal(, )
#  created_at                   :datetime
#  updated_at                   :datetime
#  is_showcase_copyrighted      :boolean
#  showcase_top_rank            :integer
#  is_showcase_archived         :boolean
#

class Performance < ActiveRecord::Base
   belongs_to :showcase

   def self.fetch_performance
        performances={}
        list=Performance.where(is_showcase_archived:false).order(:showcase_rank).limit(10)
             #Last Week Chartbusters
              performances[:candeoTopContent1]= list.size>0 ? performance_to_hash(list[0],true) : {}
              performances[:candeoTopContent2]= list.size>1 ? performance_to_hash(list[1],true) : {}
              performances[:candeoTopContent3]= list.size>2 ? performance_to_hash(list[2],true) : {}
              performances[:candeoTopContent4]= list.size>3 ? performance_to_hash(list[3],true) : {}
              performances[:candeoTopContent5]= list.size>4 ? performance_to_hash(list[4],true) : {}


              #All time top performers
              last_user=nil
              performances[:candeoTopCreator1]= RankMap.fetch_top_user_by_rank(1,last_user)
              last_user=performances[:candeoTopCreator1][:id]
              performances[:candeoTopCreator2]= RankMap.fetch_top_user_by_rank(2,last_user)
              last_user=performances[:candeoTopCreator2][:id]
              performances[:candeoTopCreator3]= RankMap.fetch_top_user_by_rank(3,last_user)

        
        Rails.logger.debug("Performances is #{performances}")
        performances

   end

   def self.performance_list(params)
        list=[]
        if !params[:rank].blank?
             Performance.where("showcase_rank > ? and is_showcase_archived='t'",params[:rank]).order(:showcase_rank).limit(50).each do |performance|
                  list.push(performance_to_hash(performance,true))
             end
        end
        puts list
        list
   end

   private

   def self.performance_to_hash(performance, has_user)
        performance_hash={}
        performance_hash=performance.as_json
        bg_url = performance.showcase.content.content_media_map && performance.showcase.content.content_media_map.media_map.media.media_type == 3 ? nil : performance.showcase.user.user_media_map.media_map.media_url
        performance_hash[:bg_url]=bg_url
        performance_hash[:media_url]=performance.showcase.content.content_media_map ? performance.showcase.content.content_media_map.media_map.media_url : nil
        if has_user
            performance_hash[:name]=performance.showcase.user.name
            performance_hash[:user_avatar_url]=performance.showcase.user.user_media_map.media_map.media_url
        end
        performance_hash
   end
end
