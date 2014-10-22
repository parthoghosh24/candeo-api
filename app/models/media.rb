# == Schema Information
#
# Table name: media
#
#  id         :integer          not null, primary key
#  type       :integer
#  name       :string(255)
#  mime_type  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

# Candeo Global Media Class. Whatever files get uploaded, this is the class which handles them.
class Media < ActiveRecord::Base
end
