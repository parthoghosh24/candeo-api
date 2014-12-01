# == Schema Information
#
# Table name: networks
#
#  id          :integer          not null, primary key
#  follower_id :integer
#  followee_id :integer
#  is_friend   :integer
#  is_blocked  :integer
#  created_at  :datetime
#  updated_at  :datetime
#  uuid        :string(255)
#

require 'rails_helper'

RSpec.describe Network, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
