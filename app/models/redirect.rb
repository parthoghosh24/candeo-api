# == Schema Information
#
# Table name: redirects
#
#  id         :integer          not null, primary key
#  token      :string
#  long_url   :string
#  created_at :datetime
#  updated_at :datetime
#

class Redirect < ActiveRecord::Base
end
