# == Schema Information
#
# Table name: shout_discussions
#
#  id         :integer          not null, primary key
#  shout_id   :integer
#  user_id    :integer
#  discussion :json
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe ShoutDiscussion, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
