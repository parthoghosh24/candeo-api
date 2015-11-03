# == Schema Information
#
# Table name: statuses
#
#  id         :integer          not null, primary key
#  mode       :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  tag        :string
#  uuid       :string
#

# @Partho - Mode defines what kind of status it is- private or public. Private is meant to be shared amongst friends.
# Public statuses appear in global and network feed. Private is seen by friends only(Need to work more on this and this is part of release 2)
# mode:   Public=1, Private=2
# tag is used to tag a status/inspirtion against which one can post a inspiriton or showcase on Candeo.

class Status < ActiveRecord::Base
  after_create :generate_uuid
  belongs_to :user
  has_one :content, as: :shareable
  accepts_nested_attributes_for :content

#Upload Media first then create content and activity
  def self.create_status(params)
    status=nil  

    status=Status.create(content_attributes:{description: params[:description], user_id:params[:user_id]}, mode:1, user_id: params[:user_id])
    if !params[:media].blank?
      media = Media.find(params[:media_id])           
      
      if !params[:referral_tag].blank?
        status.content.update(referral_tag:params[:referral_tag])
      end
      status.content.content_media_map=ContentMediaMap.create!(media_map_attributes:{media_id:media.id,media_url:media.attachment.url})              
  end
  status.id if status           
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
