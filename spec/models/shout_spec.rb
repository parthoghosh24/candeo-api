# == Schema Information
#
# Table name: shouts
#
#  id         :integer          not null, primary key
#  body       :text
#  user_id    :integer
#  is_public  :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Shout, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
