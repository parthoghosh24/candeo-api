# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  name                :string
#  email               :string
#  auth_token          :string
#  created_at          :datetime
#  updated_at          :datetime
#  uuid                :string
#  username            :string
#  about               :string
#  random_token        :integer
#  total_appreciations :integer
#  total_inspires      :integer
#  has_posted          :boolean
#  gcm_id              :string
#
# Indexes
#
#  index_users_on_username  (username)
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
