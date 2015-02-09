# == Schema Information
#
# Table name: showcase_queues
#
#  id                  :integer          not null, primary key
#  showcase_id         :integer
#  is_deleted          :boolean
#  created_at          :datetime
#  updated_at          :datetime
#  name                :string(255)
#  title               :string(255)
#  user_avatar_url     :string(255)
#  total_appreciations :integer
#  total_skips         :integer
#  bg_url              :string(255)
#  media_url           :string(255)
#  media_type          :integer
#

#If somewhatever reason post has been deleted, is_deleted is switched to true. Is Queued is true when showcase is queued for stage, if it is false, it is archieved in shows up in Performances.
class ShowcaseQueue < ActiveRecord::Base
  after_create :update_queue
  belongs_to :showcase

  def self.enqueue(showcase)
  	bg_url = showcase.content.content_media_map.media_map.media.media_type == 3 ? nil : showcase.user.user_media_map.media_map.media_url
  	ShowcaseQueue.create!(showcase_id:showcase.id,
  						  name:showcase.user.name,
  						  title:showcase.title,
  						  user_avatar_url:showcase.user.user_media_map.media_map.media_url,
  						  bg_url:bg_url,
  						  media_url:showcase.content.content_media_map.media_map.media_url,
  						  media_type:showcase.content.content_media_map.media_map.media.media_type)
  end

def self.list_limelights(params)
  list=[]
  if !params[:user_id].blank?
       count=0
       ShowcaseQueue.all.order(created_at: :desc).each do |data|
             if count ==50
                 break
             end
            if(!ResponseMap.exists?(user_id:params[:user_id].to_i, showcase_id:data.showcase.id))
                list.push({"id"=>data.id})
                count+=1
           end
       end
       return list
  else
      ShowcaseQueue.all.order(created_at: :desc).limit(50).each do |data|
           list.push({"id"=>data.id})
      end
  end
  list
end

 def  self.fetch(params)
  Rails.logger.debug("In Showase queue fetch")

  item=ShowcaseQueue.find(params[:id])
  item
 end

  private
  def update_queue
      self.update(is_deleted:false, total_appreciations:0, total_skips:0)
  end
end
