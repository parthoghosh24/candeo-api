# == Schema Information
#
# Table name: contents
#
#  id             :integer          not null, primary key
#  description    :text
#  created_at     :datetime
#  updated_at     :datetime
#  shareable_type :string(255)
#  shareable_id   :integer
#  user_id        :integer
#  uuid           :string(255)
#  referral_tag   :string(255)
#

require 'rails_helper'

RSpec.describe Content, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
