# == Schema Information
#
# Table name: showcases
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

class Showcase < ActiveRecord::Base
  belongs_to :user
  has_one :content, as: :shareable
  accepts_nested_attributes_for :content

  def self.create_showcase(params)
    showcase=Showcase.create(content_attributes:{description: params[:description]}, title:params[:title], user_id: params[:user_id])    
    showcase.content.media=Media.upload(params[:media]) if !params[:media].blank?  
    #Create Activity
  end
  
end
