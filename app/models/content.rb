# == Schema Information
#
# Table name: contents
#
#  id             :integer          not null, primary key
#  description    :text
#  created_at     :datetime
#  updated_at     :datetime
#  shareable_type :string(255)
#  shareable_id   :integer
#  user_id        :integer
#  uuid           :string(255)
#  referral_tag   :string(255)
#

# @Partho - This is the parent Content class. User will generally share Content. Now Content can be a status, a user creation or data shared between friends.
# Any user on Candeo can get inspired from a posted content. After getting inspired, user responds back with feelings and pledges. This can also have tagged content.
# In upcoming iterations, Users will be able to appreciate/ applause content too.

class Content < ActiveRecord::Base
  belongs_to :shareable, polymorphic: true
  belongs_to :user #Owner
  has_one :content_media_map #attached media
  after_create :generate_uuid

  def self.show(params)
    type=params[:type].to_i
    if(type == 1)
         content = Content.find_by(shareable_id:params[:id], shareable_type:"Showcase")
    else
        content = Content.find_by(shareable_id:params[:id], shareable_type:"Status")
    end

    contentHash=nil
    if content
        bg_url = content.user.user_media_map.media_map.media_url if content.content_media_map.media_map.media.media_type != 3
        puts "bg url #{bg_url}"
        contentHash = content.as_json
        contentHash[:media_type]=content.content_media_map.media_map.media.media_type if content.content_media_map
        contentHash[:media_url]=content.content_media_map.media_map.media_url if content.content_media_map
        contentHash[:bg_url]=bg_url
        contentHash[:user_name]=content.user.name
        contentHash[:user_avatar_url]=content.user.user_media_map.media_map.media_url
        if type == 1
           contentHash[:title]=content.shareable.title
        end
    end
    contentHash
  end

  def self.referral_tag_exists?(params)
      Content.exists?(referral_tag:params[:referral_tag])
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
