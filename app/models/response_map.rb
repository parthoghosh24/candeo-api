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
#  content_type   :integer
#

#@Partho- Response Maps hold all the mapping information between users and content.
#feeling-> 1: Happy, 2: Confident, 3: Motivated, 4: Boosted, 5: Energetic, 6: Blessed
#Content Type-> 1:Status, 2:Pledge, 3:Showcase
class ResponseMap < ActiveRecord::Base
end
