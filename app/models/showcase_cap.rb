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
	def self.update_showcase_cap
           showcase_cap = ShowcaseCap.first
           new_end_time=showcase_cap.start_time+7.days
           new_start_time=showcase_cap.start_time+7.days+30.minutes
           showcase_cap.update(end_time:new_end_time, start_time:new_start_time)
	end
end
