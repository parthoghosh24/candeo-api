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
# 1: User Posted Content
# 2: User Inspired From Content and Following User
# 3: User Posted Content in response to Inspirtion
class ActivityLog < ActiveRecord::Base
end
