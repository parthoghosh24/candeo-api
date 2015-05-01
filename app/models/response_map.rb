# == Schema Information
#
# Table name: response_maps
#
#  id                    :integer          not null, primary key
#  user_id               :integer
#  is_inspired           :integer
#  has_appreciated       :integer
#  created_at            :datetime
#  updated_at            :datetime
#  owner_id              :integer
#  appreciation_response :json
#  uuid                  :string(255)
#  inspiration_response  :json
#  content_type          :integer
#  showcase_id           :integer
#  status_id             :integer
#  has_skipped           :boolean
#  skip_response         :json
#

#@Partho- Response Maps hold all the mapping information between users and content.
#feeling-> 1: Happy, 2: Confident, 3: Motivated, 4: Boosted, 5: Energetic, 6: Blessed, 7: Crazy, 8: Epic, 9: Super
#Content Type-> 1:Status/Inspirition, 2:Showcase
#appreciate_rating -> Positive ratings
#user_id is the person who is getting inspired and/or appreciating the owner_id's inspirtion and showcase
# User follows another user when user is getting inspired from that user. Appreciation has no following flow as user can appreciate anyone on platform.

class ResponseMap < ActiveRecord::Base

  after_create :generate_uuid

  def self.get_inspired(params)
     inspiration_response ={}
     inspiration_response[:feeling] =params[:feeling]
     inspiration_response[:description] =params[:description]
     showcase = Showcase.find(params[:showcase_id])
     owner_id=showcase.user.id if showcase
     response=ResponseMap.create(user_id:params[:user_id], showcase_id:params[:showcase_id], content_type:1, is_inspired:1, inspiration_response:inspiration_response, owner_id:owner_id)
     # network_map={}
     # network_map[:user_id]=params[:user_id]
     # network_map[:owner_id]=owner_id
     # Network.create_network(network_map)
    response.id
  end

  def self.appreciate(params)
    appreciation_response={}
    appreciation_response[:rating]=params[:rating]
    appreciation_response[:feedback]=params[:feedback] #micro review
    showcase = Showcase.find(params[:showcase_id])
    owner_id=showcase.user.id if showcase
    #Create Response Map with appreciation
    response=ResponseMap.create(user_id:params[:user_id], showcase_id:params[:showcase_id], content_type:2, has_appreciated:1, owner_id:owner_id, appreciation_response: appreciation_response)
    network_map={}
     network_map[:user_id]=params[:user_id]
     network_map[:owner_id]=owner_id
     Network.create_network(network_map)
     showcase_queue = ShowcaseQueue.find_by(showcase_id:showcase.id)
     showcase_queue.update(total_appreciations:showcase_queue.total_appreciations+1)
    response.id
  end

  def self.skip(params)
    skip_response={}
    skip_response[:rating]=params[:rating]
    skip_response[:feedback]=params[:feedback] #reason
    showcase = Showcase.find(params[:showcase_id])
    owner_id=showcase.user.id if showcase
    response=ResponseMap.create(user_id:params[:user_id], showcase_id:params[:showcase_id], content_type:2, has_skipped:1, owner_id:owner_id, skip_response: skip_response)
    showcase_queue = ShowcaseQueue.find_by(showcase_id:showcase.id)
    showcase_queue.update(total_appreciations:showcase_queue.total_skips+1)
    response.id
  end

  def self.fetch_responses(params)
    list =[]
    if !params.blank?
      response_type=params[:type].to_i  
      content_id=params[:content_id]
      content = Content.find(content_id)
      if content.shareable_type=="Showcase"
        if response_type == 1 #appreciation
            response_maps = ResponseMap.where(showcase_id:content.shareable_id, has_appreciated:1).order(created_at: :desc)
        else
            response_maps = ResponseMap.where(showcase_id:content.shareable_id, is_inspired:1).order(created_at: :desc)
        end        
      else
        if response_type == 1
            response_maps = ResponseMap.where(status_id:content.shareable_id, has_appreciated:1).order(created_at: :desc)
        else
            response_maps = ResponseMap.where(status_id:content.shareable_id, is_inspired:1).order(created_at: :desc)
        end      
      end
      response_maps.each do |response_map|
         final_response = {}
         final_response[:response]=response_map.as_json
         final_response[:response][:created_at_timestamp]=response_map.created_at.to_i*1000
         user = User.find(response_map.user_id)
         final_response[:user]=user.as_json(except:[:auth_token, :email, :random_token])
         final_response[:user][:avatar_path]=user.user_media_map.media_map.media_url if user.user_media_map  
         list.push(final_response)
      end
    end    
    list
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
