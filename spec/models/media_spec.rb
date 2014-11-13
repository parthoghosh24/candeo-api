# == Schema Information
#
# Table name: media
#
#  id                 :integer          not null, primary key
#  media_type         :integer
#  created_at         :datetime
#  updated_at         :datetime
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  video_file_name    :string(255)
#  video_content_type :string(255)
#  video_file_size    :integer
#  video_updated_at   :datetime
#  audio_file_name    :string(255)
#  audio_content_type :string(255)
#  audio_file_size    :integer
#  audio_updated_at   :datetime
#  doc_file_name      :string(255)
#  doc_content_type   :string(255)
#  doc_file_size      :integer
#  doc_updated_at     :datetime
#  content_id         :integer
#

require 'rails_helper'

RSpec.describe Media, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
