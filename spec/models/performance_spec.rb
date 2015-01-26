# == Schema Information
#
# Table name: performances
#
#  id                           :integer          not null, primary key
#  showcase_id                  :integer
#  showcase_title               :string(255)
#  showcase_bg_url              :string(255)
#  showcase_media_url           :string(255)
#  showcase_media_type          :integer
#  showcase_total_appreciations :integer
#  showcase_total_skips         :integer
#  showcase_user_name           :string(255)
#  showcase_user_avatar_url     :string(255)
#  showcase_created_at          :datetime
#  showcase_rank                :integer
#  showcase_score               :decimal(, )
#  created_at                   :datetime
#  updated_at                   :datetime
#

require 'rails_helper'

RSpec.describe Performance, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
