# == Schema Information
#
# Table name: pledges
#
#  id         :integer          not null, primary key
#  mode       :integer
#  period     :integer
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

# @partho: The idea for pledge is that is more like a diary/reminder for the user. This is a text only content
# which can result in pledges like "I want to help poor", "I want to make my life better"... "I want to keep the streets clean".
# People can get inspired from pledge. A pledge can be public or private. Pledges will have an alarm like functionality which will
# trigger a notification on completion of period.(Most probably pledge will be part of 2nd release)

class Pledge < ActiveRecord::Base
  belongs_to :user
  has_one :content, as: :shareable
  accepts_nested_attributes_for :content

  def self.create_pledge(params)
    Pledge.create(content_attributes:{description: params[:description]}, mode:params[:mode], period:params[:period], user_id: params[:user_id])
    #Create Activity
  end
end
