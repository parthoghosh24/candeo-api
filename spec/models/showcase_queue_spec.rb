# == Schema Information
#
# Table name: showcase_queues
#
#  id          :integer          not null, primary key
#  showcase_id :integer
#  is_deleted  :boolean
#  is_queued   :boolean
#  created_at  :datetime
#  updated_at  :datetime
#

require 'rails_helper'

RSpec.describe ShowcaseQueue, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
