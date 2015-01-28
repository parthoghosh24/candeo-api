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
  has_one :media_map #attached media
  after_create :generate_uuid  

  def self.show(params)
    content = Content.find(params[:id])
    contentMap={}
    if content
        contentMap[:media]=nil
        contentMap[:media_type]=0
        if content.media          
          contentMap[:media]=content.media.attachment.url          
          contentMap[:media_type]=content.media.media_type
        end


        contentMap[:id]=content.shareable.id
        contentMap[:desc]=content.description
        contentMap[:user_id]=content.user.id
        contentMap[:user]=content.user.username
    end
    contentMap
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
