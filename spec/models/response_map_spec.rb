# == Schema Information
#
# Table name: response_maps
#
#  id                    :integer          not null, primary key
#  user_id               :integer
#  content_id            :integer
#  is_inspired           :integer
#  did_appreciate        :integer
#  created_at            :datetime
#  updated_at            :datetime
#  inspirition_feeling   :integer
#  owner_id              :integer
#  appreciate_rating     :integer
#  appreciate_feedback   :text
#  appreciation_reaction :json
#

require 'rails_helper'

RSpec.describe ResponseMap, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
