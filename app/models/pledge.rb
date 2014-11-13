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

class Pledge < ActiveRecord::Base
  belongs_to :user
  has_one :content, as: :shareable
  accepts_nested_attributes_for :content

  def self.create_pledge(params)
    Pledge.create(content_attributes:{description: params[:description]}, mode:params[:mode], period:params[:period], user_id: params[:user_id])
    #Create Activity
  end
end
