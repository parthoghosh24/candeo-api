# == Schema Information
#
# Table name: activity_logs
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  activity_type  :integer
#  activity       :json
#  created_at     :datetime
#  updated_at     :datetime
#  activity_level :integer
#  uuid           :string(255)
#

# @Partho - Activity Log keeps information about all the activities happening on network.
# activity_levels are privacy setting:
# 1: Public
# 2: Friends
# 3: Private

# activity_types are (Text is not final and will be customizable):
# 1: User Inspiring by Sharing Status
# 2: User Inspired from Content and Following User
# 3: User Inspiring by Sharing Content in response to Inspirtion
# 4: User Showcasing
# 5: User Showcasing Content in response to Inspirtion
# 6: User Appreciating Content
# 7: User Pledging
# 8: User Inspired from Pledge
class ActivityLog < ActiveRecord::Base
  after_create :generate_uuid
  def self.create_activity(params)
    ActivityLog.create(user_id:params[:user_id], activity_type:params[:activity_type],activity:params[:activity], activity_level: params[:activity_level])
  end

  private

  def generate_uuid
        token = SecureRandom.hex(20)
        while(self.class.exists?(uuid:token)) do
          token = SecureRandom.hex(20)
        end
        self.update(uuid:token)
  end
end
