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
#skip_rating -> "Didn't Like", "Repeated", "Offensive", "Plagiarized"
#appreciate_rating -> "Good", "Wow", "Superb", "Excellent", "Mesmerizing"
#inspire_feeling-> "Motivated", "Spirited", "Enlightened", "Happy", "Cheered", "Loved", "Blessed", "Funny", "Strong"
#Content Type-> 1:Status/Inspirition, 2:Showcase
#appreciate_rating -> Positive ratings
#user_id is the person who is getting inspired and/or appreciating the owner_id's showcase

class ResponseMap < ActiveRecord::Base

  after_create :generate_uuid

  def self.get_inspired(params)
     inspiration_response ={}
     inspiration_response[:feeling] =params[:rating]
     inspiration_response[:description] =params[:feedback]
     showcase = Showcase.find(params[:showcase_id])
     owner_id=showcase.user.id if showcase
     response=ResponseMap.create(user_id:params[:user_id], showcase_id:params[:showcase_id], content_type:1, is_inspired:1, inspiration_response:inspiration_response, owner_id:owner_id)
     if params[:user_id].to_i!=owner_id
        Thread.new do                    
          # Notifiying owner fans that owner inspiring people
             user_ids = Network.where("followee_id=? and follower_id<>?",owner_id,params[:user_id]).pluck(:follower_id)
             ids = User.where("gcm_id is not null and id in (?)",user_ids).pluck(:gcm_id)
             promoter = User.find(params[:user_id])
             feeling={1=> "Motivated", 2=>"Spirited", 3=>"Enlightened", 4=>"Happy", 5=>"Cheered", 6=>"Loved", 7=>"Blessed", 8=>"Funny", 9=>"Strong"}             
             if ids.size > 1     

                 message = {title:"#{showcase.user.name} inspiring", 
                            body:"#{promoter.name} feeling #{feeling[params[:rating].to_i]} by \"#{showcase.title}\"", 
                            imageUrl: promoter.user_media_map.media_map.media_url, 
                            bigImageUrl: "", 
                            type: "content", 
                            id: params[:showcase_id]}            
                 Notification.init
                 Notification.send(message,ids)
             end          

          #Notifying owner that he/she inspired
             ids =[]
             ids.push(showcase.user.gcm_id) if !showcase.user.gcm_id.blank?                
             if ids.size >1
                message = {title:"#{promoter.name} got inspired", 
                            body:"#{promoter.name} feeling #{feeling[params[:rating].to_i]} by \"#{showcase.title}\"", 
                            imageUrl: promoter.user_media_map.media_map.media_url, 
                            bigImageUrl: "", 
                            type: "content", 
                            id: params[:showcase_id]}            
                 Notification.init
                 Notification.send(message,ids)
             end
          ActiveRecord::Base.connection.close
      end
     end     
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
     if params[:user_id].to_i!= owner_id
        Thread.new do                    
          # Notifiying owner fans that people appreciating owner
             user_ids = Network.where("followee_id=? and follower_id<>?",owner_id,params[:user_id]).pluck(:follower_id)
             ids = User.where("gcm_id is not null and id in (?)",user_ids).pluck(:gcm_id)
             fan = User.find(params[:user_id])
             feeling={1=>"Good", 2=>"Wow", 3=>"Superb", 4=>"Excellent", 5=>"Mesmerizing"}             
             if ids.size > 1     

                 message = {title:"#{showcase.user.name} getting appreciated", 
                            body:"#{fan.name} found \"#{showcase.title}\" #{feeling[params[:rating].to_i]}", 
                            imageUrl: fan.user_media_map.media_map.media_url, 
                            bigImageUrl: "", 
                            type: "content", 
                            id: params[:showcase_id]}            
                 Notification.init
                 Notification.send(message,ids)
             end          

          #Notifying fanbase of fan who are not in owner's fanbase             
             fan_ids = Network.where("followee_id=? and follower_id not in (?)",params[:user_id], user_ids).pluck(:follower_id)
             fan_ids.push(owner_id)
             ids =User.where("gcm_id is not null and id in (?)",fan_ids).pluck(:gcm_id)             
             if ids.size >1
                message = {title:"#{fan.name} appreciated", 
                            body:"#{fan.name} found \"#{showcase.title}\" #{feeling[params[:rating].to_i]}", 
                            imageUrl: fan.user_media_map.media_map.media_url, 
                            bigImageUrl: "", 
                            type: "content", 
                            id: params[:showcase_id]}            
                 Notification.init
                 Notification.send(message,ids)
             end
          ActiveRecord::Base.connection.close
      end
     end
     
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
