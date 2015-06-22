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

  def self.fetch_list(params)
     users = unique_network(params[:id]) if !params[:id].blank?
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
