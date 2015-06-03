# == Schema Information
#
# Table name: shouts
#
#  id         :integer          not null, primary key
#  body       :text
#  user_id    :integer
#  is_public  :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Shout < ActiveRecord::Base
	belongs_to :user
end
