# == Schema Information
#
# Table name: statuses
#
#  id         :integer          not null, primary key
#  mode       :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

# @Partho - Mode defines what kind of status it is- private or public. Private is meant to be shared amongst friends.
# Public statuses appear in global and network feed. Private is seen by friends only(Need to work more on this and this is part of release 2)
# mode:   Public=1, Private=2
class Status < ActiveRecord::Base
  belongs_to :user
  has_one :content, as: :shareable
  accepts_nested_attributes_for :content

  def to_s
    id
  end

end
