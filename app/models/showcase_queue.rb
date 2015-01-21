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

class ShowcaseQueue < ActiveRecord::Base
end
