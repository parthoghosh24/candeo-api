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
#  uuid               :string(255)
#

# @partho - Candeo Global Media Class. Whatever files get uploaded, this is the class which handles them.
#type -> 1:audio 2:video 3:image 4:doc
class Media < ActiveRecord::Base
  after_create :generate_uuid
  has_attached_file :image
  belongs_to :content
  validates_attachment_content_type :image, :content_type => [ 'image/png','image/jpeg','image/jpg', 'image/gif']

  has_attached_file :video
  validates_attachment_content_type :image, :content_type => [ 'video/mp4']

  has_attached_file :audio
  validates_attachment_content_type :image, :content_type => [ 'audio/mp3', 'audio/mpeg', 'audio/ogg', 'audio/mp4a-latm', 'audio/mp4']

  has_attached_file :doc #Need to be dealt in second release
  validates_attachment_content_type :image, :content_type => [ 'application/epub+zip', 'application/pdf',  'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document']

  def self.upload(file, type)
    media=nil
    file.content_type=MIME::Types.type_for(file.original_filename).to_s
    case type
    when 1 #audio
       media = Media.create(audio:file)
    when 2 #video
       media = Media.create(video:file)
    when 3 #image
       media = Media.create(image:file)
    end
    media.update(media_type:type)
    media
  end

   private

  def generate_uuid
        token = SecureRandom.hex(20)
        while(self.class.exists?(uuid:token)) do
          token = SecureRandom.hex(20)
        end
        self.update(uuid:token)
  end
end
