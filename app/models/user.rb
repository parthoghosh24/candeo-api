# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  name                :string(255)
#  email               :string(255)
#  auth_token          :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  uuid                :string(255)
#  username            :string(255)
#  about               :string(255)
#  random_token        :integer
#  total_appreciations :integer
#  total_inspires      :integer
#  has_posted          :boolean
#  gcm_id              :string
#
# Indexes
#
#  index_users_on_username  (username)
#

#auth_token is HMAC key. Whenever user logins, a new HMAC will be generated.
class User < ActiveRecord::Base

  after_create :generate_uuid
  has_many :shouts
  has_many :showcases
  has_many :contents
  has_many :inspiritions, foreign_key: 'user_id', class_name: "Status"
  validates :email, uniqueness: true
  has_one :user_media_map #avatar

  #Social Network
  #Followers- People following me
  has_many :follower_follows, foreign_key: :followee_id, class_name: "Network"
  has_many :followers, through: :follower_follows, source: :follower
  #Followee- People I am following
  has_many :followee_follows, foreign_key: :follower_id, class_name: "Network"
  has_many :followees, through: :followee_follows, source: :followee

  def self.register(params)
    if !User.exists?(email:params[:email])
        username = params[:email][0...params[:email].index('@')]
        username = username.gsub(/[^0-9A-Za-z]/,'')
        user = User.create!(name:params[:name], email:params[:email], username:username, about: "Hello World")
        if !params[:media_id].blank?
          media = Media.find(params[:media_id])
          user.user_media_map=UserMediaMap.create!(media_map_attributes:{media_id:media.id,media_url:media.attachment.url})
        end
        return user.id
    end

  end


  def self.has_posted(params)
    response=nil
     if User.exists?(id:params[:id])
        user = User.find(params[:id])
        showcase_queue_count = ShowcaseQueue.count
        cap = ShowcaseCap.find(1)
        if(user.has_posted || showcase_queue_count>=cap.quota || Time.now > cap.end_time)
           response={state:true, start_date:cap.start_time.strftime("%Y-%m-%d %H:%M:%S")}
        else
          response={state:false, start_date:nil}
        end
     end
     response
  end

  def self.update_profile(params)
    response=nil
    if User.exists?(id:params[:id])
        user = User.find(params[:id])
        if !params[:media_id].blank?
             media = Media.find(params[:media_id])
             user.user_media_map=UserMediaMap.create!(media_map_attributes:{media_id:media.id,media_url:media.attachment.url})
        end
        user.update(name:params[:name]) if !params[:name].blank?
        user.update( about:params[:bio]) if !params[:bio].blank?
        puts user.user_media_map.media_map.media_url
        response=user.user_media_map.media_map.media_url
    end
    response
  end

  def self.show(params)
       if params[:id].blank?
          user = User.find_by(username:params[:username])
       else
          user = User.find_by(username:params[:id])
          user = User.find(params[:id]) if user.blank?

       end

       if user
            userhash = user.as_json(except:[:auth_token, :email, :random_token, :gcm_id])
             id= user.id
            userhash[:total_appreciations]=ResponseMap.where(owner_id:id,has_appreciated:true).size()
            userhash[:total_inspires]=ResponseMap.where(owner_id:id,is_inspired:true).size()
            userhash[:avatar_path]=user.user_media_map.media_map.media_url if user.user_media_map
            userhash[:current_rank]=RankMap.exists?(user_id:id) ? RankMap.where(user_id:id).order(created_at: :desc).first.rank : "Not Ranked"
            userhash[:highest_rank]=RankMap.exists?(user_id:id) ? RankMap.where(user_id:id).order(:rank).first.rank : "Not Ranked"
            return userhash
       end
       nil
  end

  def self.get_appreciations(params)
    if params[:timestamp]=="now"
      last= Time.now
    else
      last = Time.parse(params[:timestamp])
    end
    list=ResponseMap.where("user_id=? and has_appreciated=? and created_at <? ",params[:id],1,last).limit(50).order(created_at: :desc)
    appreciations=[]
    list.each do |map|
        appreciation = Showcase.find(map.showcase_id)
        appreciationHash = appreciation.as_json
        appreciationHash[:rank]=Performance.exists?(showcase_id:map.showcase_id) ? Performance.find_by(showcase_id:map.showcase_id).showcase_rank : "Not Ranked"
        appreciationHash[:user_name]=appreciation.user.name
        appreciationHash[:avatar_path]=appreciation.user.user_media_map.media_map.media_url
        bg_url = appreciation.content.content_media_map && appreciation.content.content_media_map.media_map.media.media_type == 3 ? nil : appreciation.user.user_media_map.media_map.media_url
        appreciationHash[:bg_url]=bg_url
        appreciationHash[:created_at_text]=appreciation.created_at.strftime("%d %B, %Y")
        appreciationHash[:media_url]=appreciation.content.content_media_map.media_map.media_url if appreciation.content.content_media_map
        appreciationHash[:media_type]=appreciation.content.content_media_map ? appreciation.content.content_media_map.media_map.media.media_type : 0
        appreciationHash[:appreciation_count]=ResponseMap.where(showcase_id:map.showcase_id,has_appreciated:true).size()
        appreciations.push(appreciationHash)
    end
    puts appreciations
    appreciations
  end

  def self.get_inspirations(params)
    if params[:timestamp]=="now"
      last= Time.now
    else
      last = Time.parse(params[:timestamp])
    end
    list=ResponseMap.where("user_id=? and is_inspired =? and created_at <? ",params[:id],1,last).limit(50).order(created_at: :desc)
    inspirations=[]
    list.each do |map|
        if map.content_type ==1
            inspiration = Showcase.find(map.showcase_id)
        else
            inspiration = Status.find(map.status_id)
        end

        inspirationHash = inspiration.as_json
        inspirationHash[:rank]=Performance.exists?(showcase_id:map.showcase_id) ? Performance.find_by(showcase_id:map.showcase_id).showcase_rank : "Not Ranked"
        inspirationHash[:user_name]=inspiration.user.name
        inspirationHash[:avatar_path]=inspiration.user.user_media_map.media_map.media_url
        bg_url = inspiration.content.content_media_map && inspiration.content.content_media_map.media_map.media.media_type == 3 ? nil : inspiration.user.user_media_map.media_map.media_url
        inspirationHash[:bg_url]=bg_url
        inspirationHash[:created_at_text]=inspiration.created_at.strftime("%d %B, %Y")
        inspirationHash[:media_url]=inspiration.content.content_media_map.media_map.media_url if inspiration.content.content_media_map
        inspirationHash[:media_type]=inspiration.content.content_media_map ? inspiration.content.content_media_map.media_map.media.media_type : 0
        if map.content_type==1
            inspirationHash[:inspiration_count]=ResponseMap.where(showcase_id:map.showcase_id,is_inspired:true).size()
        else
            inspirationHash[:inspiration_count]=ResponseMap.where(status_id:map.status_id,is_inspired:true).size()
        end

        inspirations.push(inspirationHash)
    end
    puts inspirations
    puts "inspirations size #{inspirations.size}"
    inspirations
  end

  def self.get_showcases(params)
      if params[:timestamp]=="now" || params[:timestamp].blank?
        last= Time.now
      else
        last = Time.parse(params[:timestamp])
     end
     list = Showcase.where("user_id=? and created_at<?",params[:id],last).order(created_at: :desc).limit(50)
     showcases=[]
     list.each do |showcase|
        showcaseHash = showcase.as_json
        showcaseHash[:rank]=Performance.exists?(showcase_id:showcase.id) ? Performance.find_by(showcase_id:showcase.id).showcase_rank : "Not Ranked"
        showcaseHash[:avatar_path]=showcase.user.user_media_map.media_map.media_url
        bg_url = showcase.content.content_media_map && showcase.content.content_media_map.media_map.media.media_type == 3 ? nil : showcase.user.user_media_map.media_map.media_url
        showcaseHash[:bg_url]=bg_url
        showcaseHash[:created_at_text]=showcase.created_at.strftime("%d %B, %Y")
        showcaseHash[:media_type]=showcase.content.content_media_map ? showcase.content.content_media_map.media_map.media.media_type : 0
        showcaseHash[:media_url]=showcase.content.content_media_map.media_map.media_url if showcase.content.content_media_map
        showcaseHash[:appreciation_count]=ResponseMap.where(showcase_id:showcase.id,has_appreciated:true).size()
        showcaseHash[:inspiration_count]=ResponseMap.where(showcase_id:showcase.id,is_inspired:true).size()
        showcaseHash[:short_id]=showcase.content.short_id
        showcases.push(showcaseHash)
     end
     showcases
  end

  def self.get_public_shouts(params)
      if params[:timestamp]=="now"
        last= Time.now
      else
        last = Time.parse(params[:timestamp])
      end
      shouts=Shout.where("user_id=? and created_at<?",params[:id],last).limit(50).order(created_at: :desc)


      shouts
  end

  def self.get_fans(params)
      if params[:timestamp]=="now"
        last= Time.now
      else
        last = Time.parse(params[:timestamp])
      end
      list=Network.where("followee_id=? and created_at<?",params[:id],last).limit(50).order(created_at: :desc)
      fans=[]
      list.each do |fan|
           user = User.find(fan.follower_id)
           userHash = user.as_json(except:[:auth_token, :email, :random_token])
           userHash[:total_appreciations]=ResponseMap.where(owner_id:fan.follower_id,has_appreciated:true).size()
            userHash[:total_inspires]=ResponseMap.where(owner_id:fan.follower_id,is_inspired:true).size()
            userHash[:avatar_path]=user.user_media_map.media_map.media_url if user.user_media_map
           fans.push(userHash)
      end
      fans
  end

  def self.get_promoted(params)
      if params[:timestamp]=="now"
        last= Time.now
      else
        last = Time.parse(params[:timestamp])
      end
      list=Network.where("follower_id=? and created_at<?",params[:id],last).limit(50).order(created_at: :desc)
      promotes=[]
      list.each do |promoted|
           user = User.find(promoted.followee_id)
           userHash = user.as_json(except:[:auth_token, :email, :random_token])
           userHash[:total_appreciations]=ResponseMap.where(owner_id:promoted.followee_id,has_appreciated:true).size()
            userHash[:total_inspires]=ResponseMap.where(owner_id:promoted.followee_id,is_inspired:true).size()
            userHash[:avatar_path]=user.user_media_map.media_map.media_url if user.user_media_map
           promotes.push(userHash)
      end
      promotes
  end

  def self.login(params)
    #generate a link with randomized token and send to user email
    response=nil
    user = User.find_by(email:params[:email])
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
      userHash = user.as_json
      userHash["avatar_path"]=user.user_media_map.media_map.media_url if user.user_media_map
      return userHash
    end
    nil
  end

  def self.update_gcm(params)
    response = nil
    if !params[:id].blank?
       user = User.find(params[:id])
       user.update(gcm_id:params[:gcm_id])
       response = user
    end
    response
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
