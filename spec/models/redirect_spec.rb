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

require 'rails_helper'

RSpec.describe Redirect, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
