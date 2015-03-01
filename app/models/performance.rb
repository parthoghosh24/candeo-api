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
#

class Performance < ActiveRecord::Base
   belongs_to :showcase

   def self.fetch_performance
        performances={}
        list=Performance.all.order(:showcase_rank).limit(10)
        #Last Week Chartbusters
        performances[:candeoTopContent1]= performance_to_hash(list[0],false)  if list and list[0]
        performances[:candeoTopContent2]= performance_to_hash(list[1],false) if list and list[1]
        performances[:candeoTopContent3]= performance_to_hash(list[2],false) if list and list[2]
        performances[:candeoTopContent4]= performance_to_hash(list[3],false) if list and list[3]
        performances[:candeoTopContent5]= performance_to_hash(list[4],false) if list and list[4]


        #All time top performers
        performances[:candeoTopCreator1]= RankMap.fetch_top_user_by_rank(1)
        performances[:candeoTopCreator2]= RankMap.fetch_top_user_by_rank(2)
        performances[:candeoTopCreator3]= RankMap.fetch_top_user_by_rank(3)

        # More Performances
        performances[:morePerformances]=performance_list({:rank => 5})

        performances

   end

   def self.performance_list(params)
        list=[]
        if !params[:rank].blank?
             Performance.where("showcase_rank > ?",params[:rank]).order(:showcase_rank).each do |performance|
                  list.push(performance_to_hash(performance,true))
             end
        end
        list
   end

   private

   def self.performance_to_hash(performance, has_user)
        performance_hash={}
        performance_hash=performance.as_json
        bg_url = performance.showcase.content.content_media_map.media_map.media.media_type == 3 ? nil : performance.showcase.user.user_media_map.media_map.media_url
        performance_hash[:bg_url]=bg_url
        performance_hash[:media_url]=performance.showcase.content.content_media_map.media_map.media_url
        if has_user
            performance_hash[:name]=performance.showcase.user.name
            performance_hash[:user_avatar_url]=performance.showcase.user.user_media_map.media_map.media_url
        end
        performance_hash
   end
end
