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


          #Notifying shout creator and participants if private
             user =User.find(params[:user_id])
             shout_ids =[]
             shout_ids.push(discussion.shout.user_id) #shout creator
             if !discussion.shout.is_public
                 participants = ShoutParticipant.where("shout_id=? and user_id not in (?)",discussion.shout.id,[discussion.shout.user_id,params[:user_id]]) #all shout participants except creator and current user
                 particpants.each do |participant|
                     shout_ids.push(participant.user_id)
                 end
             end
             ids =User.where("gcm_id is not null and id in (?)",shout_ids).pluck(:gcm_id)
             puts ids
             if ids.size >0
                message = {title:"#{user.name} messaged",
                            body:"#{user.name} messaged  in shout \"#{discussion.shout.body[0..20]}\"... ",
                            imageUrl: user.user_media_map.media_map.media_url,
                            bigImageUrl: "",
                            type: "shout",
                            id: discussion.shout.id}
                 Notification.init
                 Notification.send(message,ids)
             end


       discussion
  end

end
