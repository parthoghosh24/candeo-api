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

  def self.enqueue(showcase)
  	bg_url = showcase.content.media_map.media.media_type == 3 ? nil : showcase.user.media_map.media_url
  	ShowcaseQueue.create!(showcase_id:showcase.id, 
  						  name:showcase.user.name,
  						  title:showcase.title,
  						  user_avatar_url:showcase.user.media_map.media_url,
  						  bg_url:bg_url, 
  						  media_url:showcase.content.media_map.media_url,
  						  media_type:showcase.content.media_map.media.media_type)
  end

  def self.list(params)
  	  
  end

  private
  def update_queue
      self.update(is_deleted:false, total_appreciations:0, total_skips:0)
  end
end
