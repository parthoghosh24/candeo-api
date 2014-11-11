# == Schema Information
#
# Table name: networks
#
#  id          :integer          not null, primary key
#  follower_id :integer
#  followee_id :integer
#  is_friend   :integer
#  is_blocked  :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Network < ActiveRecord::Base
  belongs_to :follower, foreign_key:"follower_id", class_name: "User"
  belongs_to :followee, foreign_key:"followee_id", class_name: "User"

  after_create :update_network_with_defaults


  private
  def update_network_with_defaults
    # No friends or blockings when network is first created
    self.update(is_friend:0, is_blocked:0)
  end
end
