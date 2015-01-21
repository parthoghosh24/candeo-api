# == Schema Information
#
# Table name: users
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  email        :string(255)
#  auth_token   :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  uuid         :string(255)
#  username     :string(255)
#  about        :string(255)
#  random_token :integer
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
