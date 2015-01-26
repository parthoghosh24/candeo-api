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

  def self.enqueue(params)
  end

  def self.list
  end

  private
  def update_queue
      self.update(is_deleted:false)
  end
end
