# == Schema Information
#
# Table name: response_maps
#
#  id                    :integer          not null, primary key
#  user_id               :integer
#  is_inspired           :integer
#  has_appreciated       :integer
#  created_at            :datetime
#  updated_at            :datetime
#  owner_id              :integer
#  appreciation_response :json
#  uuid                  :string
#  inspiration_response  :json
#  content_type          :integer
#  showcase_id           :integer
#  status_id             :integer
#  has_skipped           :boolean
#  skip_response         :json
#

require 'rails_helper'

RSpec.describe ResponseMap, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
