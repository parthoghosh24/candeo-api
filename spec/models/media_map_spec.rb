# == Schema Information
#
# Table name: media_maps
#
#  id              :integer          not null, primary key
#  media_id        :integer
#  media_url       :string
#  created_at      :datetime
#  updated_at      :datetime
#  attachable_id   :integer
#  attachable_type :string
#  uuid            :string
#

require 'rails_helper'

RSpec.describe MediaMap, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
