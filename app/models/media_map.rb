# == Schema Information
#
# Table name: media_maps
#
#  id         :integer          not null, primary key
#  media_id   :integer
#  type_id    :integer
#  type_name  :string(255)
#  media_url  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class MediaMap < ActiveRecord::Base
	belongs_to :media
	belongs_to :user
	belongs_to :content
end
