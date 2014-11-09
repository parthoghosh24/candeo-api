# == Schema Information
#
# Table name: contents
#
#  id             :integer          not null, primary key
#  description    :text
#  media_id       :integer
#  created_at     :datetime
#  updated_at     :datetime
#  shareable_type :string(255)
#  shareable_id   :integer
#  user_id        :integer
#

# @Partho - This is the parent Content class. User will generally share Content. Now Content can be a status, a user creation or data shared between friends.
# Any user on Candeo can get inspired from a posted content. After getting inspired, user responds back with feelings and pledges. This can also have tagged content.
# In upcoming iterations, Users will be able to appreciate/ applause content too.

class Content < ActiveRecord::Base  
  belongs_to :shareable, polymorphic: true
  belongs_to :user #Owner
  has_one :media

  def self.show(params)
    content = Content.find(params[:id])
    contentMap={}
    if content
        contentMap[:media]=nil
        contentMap[:media_type]=0
        if content.media
          case content.media.media_type
          when 1
              contentMap[:media]=content.media.audio.url
          when 2
              contentMap[:media]=content.media.video.url
           when 3
              contentMap[:media]=content.media.image.url
          end
          contentMap[:media_type]=content.media.media_type
        end


        contentMap[:id]=content.id
        contentMap[:desc]=content.description
        contentMap[:user_id]=content.user.id
        contentMap[:user]=content.user.username
    end
    contentMap
  end


  def self.upload(params)
    media=nil
    case params[:type].to_i
    when 1 #audio
       media = Media.create(audio:params[:file])
    when 2 #video
       media = Media.create(video:params[:file])
    when 3 #image
       media = Media.create(image:params[:file])
    end

    content = Content.create(description:params[:description])
    user=User.find(params[:user_id])
    content.user=user
    content.media=media
    user_status=user.statuses.create(mode:1)
    user_status.content=content
  end
end
