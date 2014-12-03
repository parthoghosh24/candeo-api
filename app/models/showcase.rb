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
    showcase=Showcase.create(content_attributes:{description: params[:description]}, title:params[:title], user_id: params[:user_id], state:params[:state].to_i)
    if !params[:referral_tag].blank
      showcase.content.update(referral_tag:params[:referral_tag])
    end
    showcase.content.media=Media.upload(params[:media]) if !params[:media].blank?
    #Create Activity    
    activity = {}    
    if !params[:media].blank?
      case showcase.content.media.media_type
        when 1
            activity[:media_url]=showcase.content.media.audio.url
        when 2
            activity[:media_url]=showcase.content.media.video.url
        when 3
            activity[:media_url]=showcase.content.media.image.url
      end
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
    showcase.id
  end

  # Update Showcase state. If content passed, content uploaded(2:published) or content rejected(-1:rejected)
  def self.update_showcase(params)
    showcase = Showcase.find(params[:id])
    # If the state is draft or submit. In rest of the cases, just update the showcase reviewed state.
    if params[:state].to_i == 0 || params[:state].to_i == 1
      showcase.update(content_attributes:{description: params[:description]}, title:params[:title], user_id: params[:user_id])
    end
    showcase.update(reviewed:params[:state])
    #Create Activity
    activity = {}    
    if !params[:media].blank?
      case showcase.content.media.media_type
        when 1
            activity[:media_url]=showcase.content.media.audio.url
        when 2
            activity[:media_url]=showcase.content.media.video.url
        when 3
            activity[:media_url]=showcase.content.media.image.url
      end
    end 
    activity[:title]=params[:title] 
    activity[:showcase_id]=showcase.id
    if params[:state].to_i == 2
      if !params[:referral_tag].blank?
      activity[:referral_tag]="*params[:referral_tag]"
    end
    end
    
    activity[:state]=params[:state]   
    activity_params={}
    activity_params[:user_id]=user.id

    if params[:state].to_i == 2 #Submitted
      if !showcase.content.referral_tag.blank?
        activity_params[:activity_type]=7
      else
        activity_params[:activity_type]=6
      end
    elsif params[:state].to_i == 0 #Draft
        activity_params[:activity_type]=8
    elsif params[:state].to_i == 1 #Submitted
        activity_params[:activity_type]=9
    elsif params[:state].to_i == -1 #Rejected  
        activity_params[:activity_type]=10
    end      

        
    activity_params[:activity]=activity
    if params[:state].to_i == 2
       activity_params[:activity_level]=1 #Public 
    else
       activity_params[:activity_level]=3 #Privare
    end
          
    ActivityLog.create_activity(activity_params)
    showcase.id
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
