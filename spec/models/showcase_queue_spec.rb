# == Schema Information
#
# Table name: showcase_queues
#
#  id                  :integer          not null, primary key
#  showcase_id         :integer
#  is_deleted          :boolean
#  created_at          :datetime
#  updated_at          :datetime
#  name                :string(255)
#  title               :string(255)
#  user_avatar_url     :string(255)
#  total_appreciations :integer
#  total_skips         :integer
#  bg_url              :string(255)
#  media_url           :string(255)
#  media_type          :integer
#

require 'rails_helper'

RSpec.describe ShowcaseQueue, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
