# == Schema Information
#
# Table name: content_media_maps
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  content_id :integer
#

class ContentMediaMap < ActiveRecord::Base
	has_one :media_map, as: :attachable
	belongs_to :content
	accepts_nested_attributes_for :media_map
end
