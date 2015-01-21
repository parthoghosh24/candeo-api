# == Schema Information
#
# Table name: redirects
#
#  id         :integer          not null, primary key
#  token      :string(255)
#  long_url   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Redirect < ActiveRecord::Base
end
