# == Schema Information
#
# Table name: showcase_caps
#
#  id         :integer          not null, primary key
#  quota      :integer
#  end_time   :datetime
#  start_time :datetime
#  created_at :datetime
#  updated_at :datetime
#

class ShowcaseCap < ActiveRecord::Base
	def self.update_showcase_cap(params)
	end
end
