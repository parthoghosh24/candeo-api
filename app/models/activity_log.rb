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
#  uuid           :string
#

# @Partho - Activity Log keeps information about all the activities happening on network.
# activity_levels are privacy setting:
# 1: Public
# 2: Friends
# 3: Private

# activity_types are (Text is not final and will be customizable):
#1 : welcome
#2 : New Status/Inspirition created
#3 : New Status/Inspirition created in response to inspiration referral tag
#4 : New Showcase created
#5 : New Showcase created in response to inspiration referral tag
#6 : New Showcase published
#7 : New Showcase published in response to inspiration referral tag
#8 : Showcase drafted
#9 : Showcase submitted for review
#10 : Showcase rejected
#11 : Follower following Followee
#12 : User got inspired
#13 : User Appreciated

class ActivityLog < ActiveRecord::Base
  after_create :generate_uuid
  def self.create_activity(params)
    puts "Activity Log getting created"
    Rails.logger.debug("Activity Log getting created")
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
