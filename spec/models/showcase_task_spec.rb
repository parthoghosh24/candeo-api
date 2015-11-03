# == Schema Information
#
# Table name: showcase_tasks
#
#  id                   :integer          not null, primary key
#  cron                 :string
#  content_limit        :integer
#  last_timestamp       :datetime
#  last_timestamp_epoch :integer
#  created_at           :datetime
#  updated_at           :datetime
#  last_rank            :integer
#

require 'rails_helper'

RSpec.describe ShowcaseTask, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
