# == Schema Information
#
# Table name: shout_discussions
#
#  id         :integer          not null, primary key
#  shout_id   :integer
#  user_id    :integer
#  discussion :json
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShoutDiscussion < ActiveRecord::Base
	belongs_to :user_id
	belongs_to :shout
end
