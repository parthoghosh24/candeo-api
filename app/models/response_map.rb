# == Schema Information
#
# Table name: response_maps
#
#  id                    :integer          not null, primary key
#  user_id               :integer
#  content_id            :integer
#  is_inspired           :integer
#  did_appreciate        :integer
#  created_at            :datetime
#  updated_at            :datetime
#  owner_id              :integer
#  appreciation_reaction :json
#  uuid                  :string(255)
#  inspiration_response  :json
#  content_type          :integer
#

#@Partho- Response Maps hold all the mapping information between users and content.
#feeling-> 1: Happy, 2: Confident, 3: Motivated, 4: Boosted, 5: Energetic, 6: Blessed, 7: Crazy, 8: Epic, 9: Super
#Content Type-> 1:Status/Inspirition, 2:Pledge, 3:Showcase
#appreciate_rating -> Positive ratings
#user_id is the person who is getting inspired and/or appreciating the owner_id's inspirtion and showcase
# User follows another user when user is getting inspired from that user. Appreciation has no following flow as user can appreciate anyone on platform.

class ResponseMap < ActiveRecord::Base

  after_create :generate_uuid
  def self.get_inspired(params)
     inspiration_response ={}
     inspiration_response[:feeling] =params[:feeling]
     inspiration_response[:description] =params[:description]
     response=ResponseMap.create(user_id:params[:user_id], content_id:params[:content_id], content_type:params[:content_type], is_inspired:1, inspiration_response:inspiration_response, owner_id:params[:owner_id])
     network_map={}
     network_map[:user_id]=params[:user_id]
     network_map[:owner_id]=params[:owner_id]
     Network.create_network(network_map)
     #Create Activity
  end

  def self.appreciate(params)
    appreciation_reaction={}
    appreciation_reaction[:rating]=params[:rating]
    appreciation_reaction[:feedback]=params[:feedback] #micro review
    #Create Response Map with appreciation
    response=ResponseMap.create(user_id:params[:user_id], content_id:params[:content_id], did_appreciate:1, owner_id:params[:owner_id], appreciation_reaction: appreciation_reaction)
    #Create Activity
  end

  private

  def generate_uuid
        token = SecureRandom.hex(20)
        while(self.class.exists?(uuid:token)) do
          token = SecureRandom.hex(20)
        end
        self.update(uuid:token)
  end
end
