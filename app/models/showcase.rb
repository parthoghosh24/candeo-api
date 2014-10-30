# == Schema Information
#
# Table name: showcases
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Showcase < ActiveRecord::Base
  belongs_to :user
  has_one :content, as: :shareable
  accepts_nested_attributes_for :content
end
