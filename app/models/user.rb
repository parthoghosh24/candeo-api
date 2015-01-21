# == Schema Information
#
# Table name: users
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  email        :string(255)
#  auth_token   :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  uuid         :string(255)
#  username     :string(255)
#  about        :string(255)
#  random_token :integer
#

#auth_token is HMAC key. Whenever user logins, a new HMAC will be generated.
class User < ActiveRecord::Base

  after_create :generate_uuid  
  has_many :showcases
  has_many :contents
  has_many :inspiritions, foreign_key: 'user_id', class_name: "Status"
  validates :email, uniqueness: true
  has_one :media_map #avatar

  #Social Network
  #Followers- People following me
  has_many :follower_follows, foreign_key: :followee_id, class_name: "Network"
  has_many :followers, through: :follower_follows, source: :follower
  #Followee- People I am following
  has_many :followee_follows, foreign_key: :follower_id, class_name: "Network"
  has_many :followees, through: :followee_follows, source: :followee

  def self.register(params)
    username = params[:email][0...params[:email].index('@')]
    username = username.gsub(/[^0-9A-Za-z]/,'')
    user = User.create!(name:params[:name], email:params[:email], username:username)
    if user
      # Create Activity
      activity = {}
      activity[:name]=params[:name]
      activity_params={}
      activity_params[:user_id]=user.id
      activity_params[:activity_type]=1
      activity_params[:activity]=activity
      activity_params[:activity_level]=3 #Private
      ActivityLog.create_activity(activity_params)
      user.id
    end
  end

  def self.show(params)
  end

  def self.login(params)    
    #generate a link with randomized token and send to user email    
    response=nil
    user = User.find(params[:id])
    if user
       response ={}
       response[:user]=user
       response[:random_token]= generate_random_token       
       user.update(random_token:response[:random_token])
       Redirect.create!(token:response[:random_token].to_s,long_url:"play store link")
    end
    response 
  end

  def self.verify(params)
    #Once user clicked the link, the user email and random token received will be used to generate HMAC key for that user
    #And that HMAC key will sent which will be stored in app for further communication and API signing.
    user = User.find_by(random_token:params[:token])
    if user      
      token = params[:token]
      user.update(auth_token:generate_auth_token(user), random_token:-1)  
      redirect = Redirect.find_by(token:params[:token].to_s) 
      if redirect
         redirect.destroy
      end
      return user
    end
    user
  end

  private

  def generate_uuid
        token = SecureRandom.hex(20)
        while(self.class.exists?(uuid:token)) do
          token = SecureRandom.hex(20)
        end
        self.update(uuid:token)
  end

  def self.generate_auth_token(user)
       puts "Random token is #{user.random_token}"

       msg ="#{user.email}|#{user.random_token}"       
       auth_token= CandeoHmac.generate_hmac(user.uuid,msg)
       auth_token
  end

  def self.generate_random_token 
     token = SecureRandom.random_number(100000)
     while(User.exists?(random_token:token)) do
        token = SecureRandom.random_number(100000)
     end
     token
  end 

end
