# == Schema Information
#
# Table name: networks
#
#  id          :integer          not null, primary key
#  follower_id :integer
#  followee_id :integer
#  is_friend   :integer
#  is_blocked  :integer
#  created_at  :datetime
#  updated_at  :datetime
#  uuid        :string
#

class Network < ActiveRecord::Base
  after_create :generate_uuid
  belongs_to :follower, foreign_key:"follower_id", class_name: "User"
  belongs_to :followee, foreign_key:"followee_id", class_name: "User"

  after_create :update_network_with_defaults

  def self.create_network(params)
    if params[:user_id].to_i!=params[:owner_id].to_i && !Network.exists?(follower_id:params[:user_id], followee_id:params[:owner_id])
      network=Network.create(follower_id:params[:user_id], followee_id:params[:owner_id])
      Thread.new do                    
          # Notifiying owner that he/she has new fan             
             ids = User.where("id=? and gcm_id not null",params[:owner_id]).pluck(:gcm_id)                                  
             fan = User.find(params[:user_id])
             ids.push(showcase.user.gcm_id)                 
             if ids.size >0
                message = {title:"You have new fan", 
                            body:"#{fan.name} is now your fan", 
                            imageUrl: fan.user_media_map.media_map.media_url, 
                            bigImageUrl: "", 
                            type: "user", 
                            id: params[:user_id]}            
                 Notification.init
                 Notification.send(message,ids)
             end
          ActiveRecord::Base.connection.close
      end
      network.id
    end
  end

  private

  def update_network_with_defaults
    # No friends or blockings when network is first created
    self.update(is_friend:0, is_blocked:0)
  end

  def generate_uuid
        token = SecureRandom.hex(20)
        while(self.class.exists?(uuid:token)) do
          token = SecureRandom.hex(20)
        end
        self.update(uuid:token)
  end


end
