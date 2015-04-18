# == Schema Information
#
# Table name: showcase_queues
#
#  id                  :integer          not null, primary key
#  showcase_id         :integer
#  is_deleted          :boolean
#  created_at          :datetime
#  updated_at          :datetime
#  title               :string(255)
#  media_type          :integer
#  total_appreciations :integer
#  total_skips         :integer
#  is_copyrighted      :boolean
#

#If somewhatever reason post has been deleted, is_deleted is switched to true. Is Queued is true when showcase is queued for stage, if it is false, it is archieved in shows up in Performances.
class ShowcaseQueue < ActiveRecord::Base
  after_create :update_queue
  belongs_to :showcase

  def self.enqueue(showcase)
  	bg_url = showcase.content.content_media_map && showcase.content.content_media_map.media_map.media.media_type == 3 ? nil : showcase.user.user_media_map.media_map.media_url
      media_type= showcase.content.content_media_map ? showcase.content.content_media_map.media_map.media.media_type : 0
  	ShowcaseQueue.create!(showcase_id:showcase.id,title:showcase.title,media_type:media_type)
  end

def self.list_limelights(params)
  list=[]
  if params[:user_id].blank? or  params[:user_id].to_i==0
       ShowcaseQueue.where(is_deleted:false).order(created_at: :desc).limit(50).each do |data|
            list.push({"id"=>data.id})
       end
  else
      count=0
       ShowcaseQueue.where(is_deleted:false).order(created_at: :desc).each do |data|
             if count ==50
                 break
             end
            if(!ResponseMap.exists?(user_id:params[:user_id].to_i, showcase_id:data.showcase.id, has_appreciated:true) && !ResponseMap.exists?(user_id:params[:user_id].to_i, showcase_id:data.showcase.id, has_skipped:true))
                list.push({"id"=>data.id})
                count+=1
           end
       end
  end
  list
end

 def  self.fetch(params)
  Rails.logger.debug("In Showase queue fetch")

  item=ShowcaseQueue.find(params[:id])
  itemHash={}
  itemHash[:id]=params[:id]
  itemHash[:showcase_id]=item.showcase_id
  itemHash[:name]=item.showcase.user.name
  itemHash[:user_id]=item.showcase.user.id
  itemHash[:title]=item.title
  itemHash[:user_avatar_url]=item.showcase.user.user_media_map.media_map.media_url
  itemHash[:total_appreciations]= item.total_appreciations
  itemHash[:total_skips]=item.total_skips
  bg_url = item.showcase.content.content_media_map.media_map.media.media_type == 3 ? nil : item.showcase.user.user_media_map.media_map.media_url
  itemHash[:bg_url]=bg_url
  itemHash[:media_url]=item.showcase.content.content_media_map.media_map.media_url
  itemHash[:media_type]=item.media_type.blank? ? 0 : item.media_type
  puts itemHash
  itemHash
 end

  private
  def update_queue
      self.update(is_deleted:false, total_appreciations:0, total_skips:0)
  end
end
