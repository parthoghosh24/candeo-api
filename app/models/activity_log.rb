# == Schema Information
#
# Table name: activity_logs
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  activity_type :integer
#  activity      :json
#  created_at    :datetime
#  updated_at    :datetime
#

# @Partho - Activity Log keeps information about all the activities happening on network.
# activity_types are:
# 1: User Inspiring by Content
# 2: User Inspired from Content and Following User
# 3: User Inspiring by Content in response to Inspirtion
# 4: User Showcasing Content
# 5: User Showcasing Content in response to Inspirtion
# 6: User Appreciating 
class ActivityLog < ActiveRecord::Base
  def self.create_activity(params)
  end
end
