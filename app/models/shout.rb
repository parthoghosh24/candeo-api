# == Schema Information
#
# Table name: shouts
#
#  id         :integer          not null, primary key
#  body       :text
#  user_id    :integer
#  is_public  :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Shout < ActiveRecord::Base
	belongs_to :user

 def self.create(params)
     user = User.find(params[:id])
     shout = user.shouts.create(body:params[:body])
     shout.is_public=true
     if params[:public] == "0" #Private
         shout.is_public=false
         ids = params[:ids]
         ids.split(",").each do |id|
             ShoutParticipant.create(user_id:id, shout_id:shout.id, is_owner:false)
         end
         ShoutParticipant.create(user_id:user.id, shout_id:shout.id, is_owner:true)
     end
     shout.save
     shout
 end

  def self.fetch_list(params)
     network = unique_network(params[:id]) if !params[:id].blank?
     user = User.find(params[:id])
     ids = network.pluck(:id)
     ids.push(params[:id])
     all = []
     shouts = ids.size>0 ? Shout.where(user_id:ids,is_public:true).order(created_at: :desc) : [] # Pull all public shouts (user + user's network)
     all.push(shouts)
     shout_participants = ShoutParticipant.exists?(user_id:params[:id]) ? ShoutParticipant.where(user_id:params[:id]).order(created_at: :desc) : [] # Pull all private shouts where user is participant
     shouts=[]
     if shout_participants.size > 0
      shout_participants.each do |shout_participant|
         shouts.push(shout_participant.shout)
      end
     end
     all.push(shouts)
     all.sort_by{|map| -map[:created_at]} if all.size>0 #Sorting the array with created_at descending
     all

  end

  def self.fetch_network(params)

     users = unique_network(params[:id]) if !params[:id].blank?
     users_list=[]
     users.each do |user|
      user_hash = user.as_json(except:[:auth_token, :email, :random_token])
      user_hash[:avatar_path]=user.user_media_map.media_map.media_url if user.user_media_map
      users_list.push(user_hash)
     end
     users_list
  end

  private
  def self.unique_network(id)
      users = nil
      query1 = Network.where(followee_id:id).select(:follower_id)
      query2= Network.where("followee_id in (select followee_id from networks where follower_id=?) and follower_id<>?",id,id).select(:follower_id)
      sql = Network.connection.unprepared_statement{"((#{query1.to_sql}) UNION (#{query2.to_sql}))as networks"}
      final_query=Network.from(sql)
      if final_query.size > 0
          users = User.where(id:final_query.pluck(:follower_id))
      end
      users
  end
end
