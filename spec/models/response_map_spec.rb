# == Schema Information
#
# Table name: response_maps
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  content_id     :integer
#  is_inspired    :integer
#  did_appreciate :integer
#  created_at     :datetime
#  updated_at     :datetime
#  feeling        :integer
#  owner_id       :integer
#

require 'rails_helper'

RSpec.describe ResponseMap, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
