# == Schema Information
#
# Table name: statuses
#
#  id         :integer          not null, primary key
#  mode       :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  tag        :string(255)
#

# @Partho - Mode defines what kind of status it is- private or public. Private is meant to be shared amongst friends.
# Public statuses appear in global and network feed. Private is seen by friends only(Need to work more on this and this is part of release 2)
# mode:   Public=1, Private=2
# tag is used to tag a status/inspirtion against which one can post a inspiriton or showcase on Candeo.
class Status < ActiveRecord::Base
  belongs_to :user
  has_one :content, as: :shareable
  accepts_nested_attributes_for :content

  def self.create_status(params)
    status=Status.create(content_attributes:{description: params[:description]}, mode:1, user_id: params[:user_id], tag:params[:tag])
    status.content.media=Media.upload(params[:media]) if !params[:media].blank?
    #Create Activity
  end

end
