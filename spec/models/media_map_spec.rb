# == Schema Information
#
# Table name: media_maps
#
#  id         :integer          not null, primary key
#  media_id   :integer
#  type_id    :integer
#  type_name  :string(255)
#  media_url  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe MediaMap, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
