# == Schema Information
#
# Table name: showcase_tasks
#
#  id                   :integer          not null, primary key
#  cron                 :string(255)
#  content_limit        :integer
#  last_timestamp       :datetime
#  last_timestamp_epoch :integer
#  created_at           :datetime
#  updated_at           :datetime
#

class ShowcaseTask < ActiveRecord::Base
end
