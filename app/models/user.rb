# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  auth_token :string(255)
#  created_at :datetime
#  updated_at :datetime
#  uuid       :string(255)
#  username   :string(255)
#  about      :string(255)
#

class User < ActiveRecord::Base

  after_create :generate_uuid
  after_create :generate_auth_token
  has_many :showcases
  has_many :contents
  has_many :inspiritions, foreign_key: 'user_id', class_name: "Status"
  validates :email, uniqueness: true

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
    user = User.create(name:params[:name], email:params[:email], username:username)
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

  private

  def generate_uuid
        token = SecureRandom.hex(20)
        while(self.class.exists?(uuid:token)) do
          token = SecureRandom.hex(20)
        end
        self.update(uuid:token)
  end

  def generate_auth_token
       auth_token = SecureRandom.base64(20).tr('+/=1TO0','pqrsxyz')
       while(self.class.exists?(auth_token:auth_token)) do
            auth_token = SecureRandom.base64(20).tr('+/=1TO0','pqrsxyz')
       end
       self.update(auth_token:auth_token)
  end

end
