# == Schema Information
#
# Table name: shout_participants
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  shout_id   :integer
#  is_owner   :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe ShoutParticipant, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
