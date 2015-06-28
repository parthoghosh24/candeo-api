# == Schema Information
#
# Table name: shout_discussions
#
#  id         :integer          not null, primary key
#  shout_id   :integer
#  user_id    :integer
#  discussion :json
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShoutDiscussion < ActiveRecord::Base
	belongs_to :user
	belongs_to :shout

  def self.create_discussion(params)
       discussion_message={}
       discussion_message[:text]=params[:discussion]
       discussion = ShoutDiscussion.create(shout_id:params[:shout_id], user_id:params[:user_id],discussion:discussion_message)
       discussion
  end

end
