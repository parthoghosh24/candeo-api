# == Schema Information
#
# Table name: shout_participants
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  shout_id   :integer
#  is_owner   :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShoutParticipant < ActiveRecord::Base
	belongs_to :user
	belongs_to :shout
end
