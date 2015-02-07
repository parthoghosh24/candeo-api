# == Schema Information
#
# Table name: user_media_maps
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

class UserMediaMap < ActiveRecord::Base
	has_one :media_map, as: :attachable
	belongs_to :user
	accepts_nested_attributes_for :media_map
end
