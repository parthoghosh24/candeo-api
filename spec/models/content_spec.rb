# == Schema Information
#
# Table name: contents
#
#  id             :integer          not null, primary key
#  description    :text
#  media_id       :integer
#  created_at     :datetime
#  updated_at     :datetime
#  shareable_type :string(255)
#  shareable_id   :integer
#  user_id        :integer
#

require 'rails_helper'

RSpec.describe Content, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
