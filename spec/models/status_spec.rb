# == Schema Information
#
# Table name: statuses
#
#  id         :integer          not null, primary key
#  mode       :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  tag        :string
#  uuid       :string
#

require 'rails_helper'

RSpec.describe Status, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
