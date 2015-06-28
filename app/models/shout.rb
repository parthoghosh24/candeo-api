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
     if params[:type] == "0" #Private
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

def self.fetch(params)
  shout_hash={}
  shout = Shout.find(params[:id])
  shout_hash=shout.as_json
  shout_hash["avatar_path"]= shout.user.user_media_map.media_map.media_url if shout.user.user_media_map
  shout_hash["name"]=shout.user.name
  shout_hash["user_id"]=shout.user.id
  shout_hash["created_at_timestamp"]=shout.created_at.to_i*1000
  if !shout.is_public
      #make json of all participants add add to shout_hash
      participants=ShoutParticipant.where(shout_id:params[:id])
      participant_list=[]
      participants.each do |participant|
        participant_hash = participant.as_json
        participant_hash["avatar_path"]=participant.user.user_media_map.media_map.media_url if participant.user.user_media_map
        participant_list.push(participant_hash)
      end
      shout_hash["participants"] =participant_list
  end
  shout_hash
end

def self.fetch_more_shout_discussion(params)
    if params[:timestamp]=="now"
      list=ShoutDiscussion.where(shout_id:params[:id]).limit(10).order(:created_at)
    else
      if !params[:timestamp].include?("z")
         last = Time.parse(params[:timestamp]+"z").utc+1.second
      else
          last = Time.parse(params[:timestamp]).utc+1.second
      end
      list=ShoutDiscussion.where("shout_id=? and created_at >? ",params[:id],last).limit(10).order(:created_at)
    end

    discussions =[]
    list.each do |discussion|
        discussion_hash = discussion.as_json
        discussion_hash["name"]=discussion.user.name
        discussion_hash["user_id"]=discussion.user.id
        discussions.push(discussion_hash)
    end
    puts discussions
    discussions
end

def self.is_eligible_to_shout(params) # Has atleast one follower or atleast following one
    response={}
     if Network.exists?(follower_id:params[:id]) or Network.exists?(followee_id:params[:id])
          response[:state]=true
     else
          response[:state]=false
     end
     response
  end

  def self.fetch_list(params)
     network = unique_network(params[:id]) if !params[:id].blank?
     user = User.find(params[:id])
     ids = !network.blank? ? network.pluck(:id) : []
     ids.push(params[:id])

     shouts = ids.size>0 ? Shout.where(user_id:ids,is_public:true).order(created_at: :desc) : [] # Pull all public shouts (user + user's network)

     shout_participants = ShoutParticipant.exists?(user_id:params[:id]) ? ShoutParticipant.where(user_id:params[:id]).order(created_at: :desc) : [] # Pull all private shouts where user is participant

     if shout_participants.size > 0
      shout_participants.each do |shout_participant|
         shouts.push(shout_participant.shout)
      end
     end



     # all.sort_by{|map| -map.created_at} if all.size>0
     result=[]
     shouts.each do |shout|
        shout_hash=shout.as_json
        shout_hash["avatar_path"]= shout.user.user_media_map.media_map.media_url if shout.user.user_media_map
        shout_hash["name"]=shout.user.name
        shout_hash["created_at_timestamp"]=shout.created_at.to_i*1000
        result.push(shout_hash)
     end
     result=result.sort_by{|map| map["created_at"]}.reverse#Sorting the array with created_at descending
     puts result
     result

  end

  def self.fetch_network(params)

     users = unique_network(params[:id]) if !params[:id].blank?
     users_list=[]
     if !users.blank?
        users.each do |user|
          user_hash = user.as_json(except:[:auth_token, :email, :random_token])
          user_hash[:avatar_path]=user.user_media_map.media_map.media_url if user.user_media_map
          users_list.push(user_hash)
        end
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
