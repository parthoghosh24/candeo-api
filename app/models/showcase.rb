# == Schema Information
#
# Table name: showcases
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#  state      :integer
#  uuid       :string(255)
#

#@Partho- Showcase is the creative side of candeo. Users are supposed to share original content which either they created or
# has the rights to share on candeo as they will be tagged with copyright.
#state-> 0:draft 1:submitted 2:published -1:rejected
#
class Showcase < ActiveRecord::Base
  after_create :generate_uuid
  belongs_to :user
  has_one :content, as: :shareable
  accepts_nested_attributes_for :content

  def self.create_showcase(params)
    showcase =nil    
    if media
      showcase=Showcase.create(content_attributes:{description: params[:description], user_id:params[:user_id]}, title:params[:title], user_id: params[:user_id], state:2) #state needs to be implemented after people's usage
      if !params[:referral_tag].blank?
        showcase.content.update(referral_tag:params[:referral_tag])
      end
      if !params[:media_id].blank?
        media = Media.find(params[:media_id])
        showcase.content.media_map=MediaMap.create!(media_id:media.id,media_url:media.attachment.url, type_id:showcase.content.id, type_name:"Content")
      end
      
      #Create Activity
      activity = {}
      if !params[:media].blank?
          activity[:media_url]=showcase.content.media_map.media_url
      end
      activity[:title]=params[:title]
      activity[:showcase_id]=showcase.id
      if !params[:referral_tag].blank?
        activity[:referral_tag]="*params[:referral_tag]"
      end
      activity[:state]=params[:state]
      activity_params={}
      activity_params[:user_id]=user.id
      if !params[:referral_tag].blank?
        activity_params[:activity_type]=5
      else
        activity_params[:activity_type]=4
      end
      activity_params[:activity]=activity
      activity_params[:activity_level]=3 #Private
      ActivityLog.create_activity(activity_params)
      ShowcaseQueue.enqueue(showcase)
      showcase.id
    end

  end  

  private

  def generate_uuid
        token = SecureRandom.hex(20)
        while(self.class.exists?(uuid:token)) do
          token = SecureRandom.hex(20)
        end
        self.update(uuid:token)
  end
end
