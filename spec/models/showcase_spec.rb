# == Schema Information
#
# Table name: showcases
#
#  id             :integer          not null, primary key
#  title          :string
#  created_at     :datetime
#  updated_at     :datetime
#  user_id        :integer
#  state          :integer
#  uuid           :string
#  is_copyrighted :boolean
#

require 'rails_helper'

RSpec.describe Showcase, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
