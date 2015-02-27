# == Schema Information
#
# Table name: showcases
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  user_id        :integer
#  state          :integer
#  uuid           :string(255)
#  is_copyrighted :boolean
#

require 'rails_helper'

RSpec.describe Showcase, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
