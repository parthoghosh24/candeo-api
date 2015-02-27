# == Schema Information
#
# Table name: showcase_queues
#
#  id                  :integer          not null, primary key
#  showcase_id         :integer
#  is_deleted          :boolean
#  created_at          :datetime
#  updated_at          :datetime
#  title               :string(255)
#  media_type          :integer
#  total_appreciations :integer
#  total_skips         :integer
#  is_copyrighted      :boolean
#

require 'rails_helper'

RSpec.describe ShowcaseQueue, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
