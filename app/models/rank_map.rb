# == Schema Information
#
# Table name: rank_maps
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  rank       :integer
#  count      :integer
#  created_at :datetime
#  updated_at :datetime
#

class RankMap < ActiveRecord::Base


  def self.create_or_update(user_id,rank)
       rank_map = RankMap.find_by(user_id:user_id, rank:rank)
       if rank_map
          rank_map.update(count:rank_map.count+1)
       else
           rank_map=RankMap.create!(user_id:user_id,rank:rank,count:1)
       end
        rank_map
   end

   #Since, a single user can have multiple ranks, unique users need to be selected

   def self.fetch_top_user_by_rank(rank, last_users)
      if last_users.blank? or last_users and last_users.size==0
          rank_map=RankMap.where(rank:rank).order(count: :desc).first
      else
          rank_map=RankMap.where("user_id not in (?) and rank=?",last_users,rank).order(count: :desc).first
      end
      userMap={}
      if rank_map
           user= User.find(rank_map.user_id)
           userMap = user.as_json(except:[:auth_token, :email, :random_token])
           userMap[:user_avatar_url]=user.user_media_map.media_map.media_url if user.user_media_map
      end
      userMap
   end

end
