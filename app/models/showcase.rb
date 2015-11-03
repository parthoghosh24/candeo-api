# == Schema Information
#
# Table name: showcases
#
#  id             :integer          not null, primary key
#  title          :string
#  created_at     :datetime
#  updated_at     :datetime
#  user_id        :integer
#  state          :integer
#  uuid           :string
#  is_copyrighted :boolean
#

#@Partho- Showcase is the creative side of candeo. Users are supposed to share original content which either they created or
# has the rights to share on candeo as they will be tagged with copyright.
#state-> 0:draft 1:submitted 2:published -1:rejected
#
class Showcase < ActiveRecord::Base
  after_create :generate_uuid
  belongs_to :user
  has_one :content, as: :shareable
  has_one :showcase_queue
  accepts_nested_attributes_for :content

  def self.create_showcase(params)
    showcase =nil
    showcase=Showcase.create(content_attributes:{user_id:params[:user_id], description:params[:description]}, title:params[:title], user_id: params[:user_id], state:2) #state needs to be implemented after people's usage
    if !params[:referral_tag].blank?
      showcase.content.update(referral_tag:params[:referral_tag])
    end

    if !params[:media_id].blank?
      media = Media.find(params[:media_id])
      showcase.content.content_media_map=ContentMediaMap.create!(media_map_attributes:{media_id:media.id,media_url:media.attachment.url})
    end




      #lock user to further create till next week
      showcase.user.update(has_posted:true)
      ShowcaseQueue.enqueue(showcase)
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
