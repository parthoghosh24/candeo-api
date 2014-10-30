# == Schema Information
#
# Table name: pledges
#
#  id         :integer          not null, primary key
#  mode       :integer
#  period     :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe Pledge, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
