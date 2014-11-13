# == Schema Information
#
# Table name: response_maps
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  content_id     :integer
#  is_inspired    :integer
#  did_appreciate :integer
#  created_at     :datetime
#  updated_at     :datetime
#  feeling        :integer
#  owner_id       :integer
#

#@Partho- Response Maps hold all the mapping information between users and content.
#feeling-> 1: Happy, 2: Confident, 3: Motivated, 4: Boosted, 5: Energetic, 6: Blessed, 7: Crazy, 8: Epic, 9: Super
#Content Type-> 1:Status/Inspirition, 2:Pledge, 3:Showcase
#user_id is the person who is getting inspired and/or appreciating the owner_id's inspirtion, showcase and/or pledge
class ResponseMap < ActiveRecord::Base
  def self.get_inspired(params)    
     ResponseMap.create(user_id:params[:user_id], content_id:params[:content_id], is_inspired:1, did_appreciate:0, feeling:params[:feeling], owner_id:params[:owner_id])  
     response_content=nil
     case params[:content_type].to_i
       when 1 #status       
       when 2 #showcase 
     end
     #Create Activity
  end

  def self.appreciate(params)
    #Create Response Map with appreciation
    
    #Create Activity
  end
end
