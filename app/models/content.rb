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
#
# Indexes
#
#  index_contents_on_uuid  (uuid)
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
    if(type == 1)
         content = Content.find_by(shareable_id:params[:id], shareable_type:"Showcase")
    else
        content = Content.find_by(shareable_id:params[:id], shareable_type:"Status")
    end


    if content
        contentHash = content.as_json
        bg_url = content.content_media_map && content.content_media_map.media_map.media.media_type == 3 ? nil : content.user.user_media_map.media_map.media_url
        if(type == 1)
          contentHash[:has_been_inspired]=ResponseMap.exists?(user_id:params[:user_id], showcase_id:params[:id], is_inspired:1)
        else
          contentHash[:has_been_inspired]=ResponseMap.exists?(user_id:params[:user_id], status_id:params[:id], is_inspired:1)
        end
        puts "bg url #{bg_url}"
        contentHash[:media_type]=content.content_media_map ? content.content_media_map.media_map.media.media_type : 0
        contentHash[:media_url]=content.content_media_map.media_map.media_url if content.content_media_map
        contentHash[:bg_url]=bg_url
        contentHash[:user_name]=content.user.name
        contentHash[:user_id]=content.user.id
        contentHash[:user_avatar_url]=content.user.user_media_map.media_map.media_url
        if type == 1
           contentHash[:title]=content.shareable.title
           contentHash[:appreciate_count]=ResponseMap.where(showcase_id:params[:id], has_appreciated:true).size()
           contentHash[:skip_count]=ResponseMap.where(showcase_id:params[:id], has_skipped:true).size()
           contentHash[:inspired_count]=ResponseMap.where(showcase_id:params[:id], is_inspired:true).size()
        else
           contentHash[:inspired_count]=ResponseMap.where(status_id:params[:id], is_inspired:true).size()
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

  def self.referral_tag_exists?(params)
      Content.exists?(referral_tag:params[:referral_tag])
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
