# == Schema Information
#
# Table name: pledges
#
#  id         :integer          not null, primary key
#  mode       :integer
#  period     :integer
#  created_at :datetime
#  updated_at :datetime
#

class Pledge < ActiveRecord::Base
  belongs_to :user
  has_one :content, as: :shareable
  accepts_nested_attributes_for :content
end
