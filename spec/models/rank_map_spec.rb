# == Schema Information
#
# Table name: rank_maps
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  rank       :integer
#  count      :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe RankMap, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
