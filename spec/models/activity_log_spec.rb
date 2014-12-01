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

require 'rails_helper'

RSpec.describe ActivityLog, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
