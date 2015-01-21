# == Schema Information
#
# Table name: media
#
#  id                      :integer          not null, primary key
#  media_type              :integer
#  created_at              :datetime
#  updated_at              :datetime
#  uuid                    :string(255)
#  attachment_file_name    :string(255)
#  attachment_content_type :string(255)
#  attachment_file_size    :integer
#  attachment_updated_at   :datetime
#

require 'rails_helper'

RSpec.describe Media, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
