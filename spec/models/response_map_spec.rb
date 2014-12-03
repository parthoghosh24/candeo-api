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
#  owner_id              :integer
#  appreciation_reaction :json
#  uuid                  :string(255)
#  inspiration_response  :json
#

require 'rails_helper'

RSpec.describe ResponseMap, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
