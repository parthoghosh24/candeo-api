# == Schema Information
#
# Table name: showcases
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#  state      :integer
#

#@Partho- Showcase is the creative side of candeo. Users are supposed to share original content which either they created or
# has the rights to share on candeo as they will be tagged with copyright. 
#reviewed-> 0:draft 1:submitted 2:published -1:rejected
#
class Showcase < ActiveRecord::Base
  belongs_to :user
  has_one :content, as: :shareable
  accepts_nested_attributes_for :content

  def self.create_showcase(params)
    showcase=Showcase.create(content_attributes:{description: params[:description]}, title:params[:title], user_id: params[:user_id], reviewed:params[:state])    
    showcase.content.media=Media.upload(params[:media]) if !params[:media].blank?  
    #Create Activity
  end

  # Update Showcase state. If content passed, content uploaded(2:published) or content rejected(-1:rejected)  
  def self.update_showcase_state(params)
    showcase = Showcase.find(params[:id])
    # If the state is draft or submit. In rest of the cases, just update the showcase reviewed state. 
    if params[:state].to_i == 0 || params[:state].to_i == 1
      showcase.update(content_attributes:{description: params[:description]}, title:params[:title], user_id: params[:user_id])
    end
    showcase.update(reviewed:params[:state])
    #Create Activity
  end
end
