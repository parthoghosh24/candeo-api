# == Schema Information
#
# Table name: contents
#
#  id             :integer          not null, primary key
#  description    :text
#  created_at     :datetime
#  updated_at     :datetime
#  shareable_type :string
#  shareable_id   :integer
#  user_id        :integer
#  uuid           :string
#  referral_tag   :string
#  short_id       :string
#
# Indexes
#
#  index_contents_on_short_id  (short_id)
#  index_contents_on_uuid      (uuid)
#

require 'rails_helper'

RSpec.describe Content, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
