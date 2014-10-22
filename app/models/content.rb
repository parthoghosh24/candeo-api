# == Schema Information
#
# Table name: contents
#
#  id             :integer          not null, primary key
#  description    :text
#  media_id       :integer
#  created_at     :datetime
#  updated_at     :datetime
#  shareable_type :string(255)
#  shareable_id   :integer
#

# @Partho - This is the parent Content class. User will generally share Content. Now Content can be a status, a user creation or data shared between friends.
# Any user on Candeo can get inspired from a posted content. After getting inspired, user responds back with feelings and pledges. This can also have tagged content.
# In upcoming iterations, Users will be able to appreciate/ applause content too.

class Content < ActiveRecord::Base
  belongs_to :shareable, polymorphic: true
  belongs_to :user #Owner 
  has_one :media
end
