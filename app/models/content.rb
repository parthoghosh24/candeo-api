# == Schema Information
#
# Table name: contents
#
#  id             :integer          not null, primary key
#  description    :text
#  created_at     :datetime
#  updated_at     :datetime
#  shareable_type :string(255)
#  shareable_id   :integer
#  user_id        :integer
#  uuid           :string(255)
#  referral_tag   :string(255)
#  short_id       :string
#
# Indexes
#
#  index_contents_on_short_id  (short_id)
#  index_contents_on_uuid      (uuid)
#

# @Partho - This is the parent Content class. User will generally share Content. Now Content can be a status, a user creation or data shared between friends.
# Any user on Candeo can get inspired from a posted content. After getting inspired, user responds back with feelings and pledges. This can also have tagged content.
# In upcoming iterations, Users will be able to appreciate/ applause content too.

class Content < ActiveRecord::Base
  belongs_to :shareable, polymorphic: true
  belongs_to :user #Owner
  has_one :content_media_map #attached media
  after_create :generate_uuid

  def self.show(params)
    type=params[:type].to_i
    contentHash=nil
    if type == 1
         if params[:id].blank?
            content = Content.find_by(short_id:params[:short], shareable_type:"Showcase")
         else
            content = Content.find_by(shareable_id:params[:id], shareable_type:"Showcase")
            content = Content.find_by(short_id:params[:id], shareable_type:"Showcase") if content.blank?
         end

    else

        if params[:id].blank?
            content = Content.find_by(short_id:params[:short], shareable_type:"Status")
        else
            content = Content.find_by(shareable_id:params[:id], shareable_type:"Status")
            content = Content.find_by(short_id:params[:id], shareable_type:"Status") if content.blank?
        end

    end


    if content
        contentHash = content.as_json
        id=content.id
        bg_url = content.content_media_map && content.content_media_map.media_map.media.media_type == 3 ? nil : content.user.user_media_map.media_map.media_url
        if(type == 1)
          contentHash[:has_been_inspired]=ResponseMap.exists?(user_id:params[:user_id], showcase_id:id, is_inspired:1)
        else
          contentHash[:has_been_inspired]=ResponseMap.exists?(user_id:params[:user_id], status_id:id, is_inspired:1)
        end
        puts "bg url #{bg_url}"
        contentHash[:media_type]=content.content_media_map ? content.content_media_map.media_map.media.media_type : 0
        contentHash[:media_url]=content.content_media_map.media_map.media_url if content.content_media_map
        contentHash[:bg_url]=bg_url
        contentHash[:user_name]=content.user.name
        contentHash[:web_user_name]=content.user.username
        contentHash[:user_id]=content.user.id
        contentHash[:user_avatar_url]=content.user.user_media_map.media_map.media_url
        if type == 1
           contentHash[:title]=content.shareable.title
           contentHash[:appreciate_count]=ResponseMap.where(showcase_id:id, has_appreciated:true).size()
           contentHash[:skip_count]=ResponseMap.where(showcase_id:id, has_skipped:true).size()
           contentHash[:inspired_count]=ResponseMap.where(showcase_id:id, is_inspired:true).size()
        else
           contentHash[:inspired_count]=ResponseMap.where(status_id:id, is_inspired:true).size()
        end
        contentHash[:created_at]=content.created_at.strftime("%d %B, %Y")


    end
    contentHash
  end

  def self.fetch_responses(params)
       if params[:timestamp]=="now"
        last= Time.now
      else
        last = Time.parse(params[:timestamp])
     end
     list = ResponseMap.where("user_id=? and created_at<?",params[:id],last).order(created_at: :desc).limit(10)
     showcases=[]
     list.each do |showcase|
        showcaseHash = showcase.as_json
        showcaseHash[:rank]=Performance.exists?(showcase_id:showcase.id) ? Performance.find_by(showcase_id:map.showcase.id).showcase_rank : "Not Ranked"
        showcaseHash[:avatar_path]=showcase.user.user_media_map.media_map.media_url
        bg_url = showcase.content.content_media_map.media_map.media.media_type == 3 ? nil : showcase.user.user_media_map.media_map.media_url
        showcaseHash[:bg_url]=bg_url
        showcaseHash[:created_at_text]=showcase.created_at.strftime("%d %B, %Y")
        showcaseHash[:media_type]=showcase.content.content_media_map ? showcase.content.content_media_map.media_map.media.media_type : 0
        showcaseHash[:appreciation_count]=ResponseMap.where(showcase_id:showcase.id,has_appreciated:true).size()
        showcaseHash[:inspiration_count]=ResponseMap.where(showcase_id:showcase.id,is_inspired:true).size()
        showcases.push(showcaseHash)
     end
     showcases
  end

  def self.web_top_performances
      list = Performance.order(:showcase_rank).limit(6)
     performances=[]
     list.each do |performance|
        showcase = performance.showcase
        performance_hash = showcase.as_json
        performance_hash[:rank]=Performance.exists?(showcase_id:showcase.id) ? Performance.find_by(showcase_id:showcase.id).showcase_rank : "Not Ranked"
        performance_hash[:avatar_path]=showcase.user.user_media_map.media_map.media_url
        performance_hash[:web_user_name]=showcase.user.username
        bg_url = showcase.content.content_media_map && showcase.content.content_media_map.media_map.media.media_type == 3 ? nil : showcase.user.user_media_map.media_map.media_url
        performance_hash[:bg_url]=bg_url
        performance_hash[:created_at_text]=showcase.created_at.strftime("%d %B, %Y")
        performance_hash[:media_type]=showcase.content.content_media_map ? showcase.content.content_media_map.media_map.media.media_type : 0
        performance_hash[:media_url]=showcase.content.content_media_map.media_map.media_url if showcase.content.content_media_map
        performance_hash[:appreciation_count]=ResponseMap.where(showcase_id:showcase.id,has_appreciated:true).size()
        performance_hash[:inspiration_count]=ResponseMap.where(showcase_id:showcase.id,is_inspired:true).size()
        performance_hash[:short_id]=showcase.content.short_id
        performances.push(performance_hash)
     end
     performances
  end

  def self.referral_tag_exists?(params)
      Content.exists?(referral_tag:params[:referral_tag])
  end

  private

  def generate_uuid
        token = SecureRandom.hex(20)
        while(self.class.exists?(uuid:token)) do
          token = SecureRandom.hex(20)
        end
         hashids = Hashids.new(token, 5)
         hash = hashids.encode(self.id)
         self.update(uuid:token,short_id:hash)
  end
end
