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
  belongs_to :content

  has_attached_file :image
  validates_attachment_content_type :image, :content_type => ['image/jpeg','image/jpg','image/png']

  has_attached_file :video
  validates_attachment_content_type :video, :content_type => [ 'video/mp4','video/3gpp']

  has_attached_file :audio
  validates_attachment_content_type :audio, :content_type => [ 'audio/mp3']

  #has_attached_file :doc #Need to be dealt in second release
  #validates_attachment_content_type :image, :content_type => [ 'application/epub+zip', 'application/pdf',  'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document']

  def self.upload(file, type)
    media=nil

    case type
    when 1 #audio
       f = file.tempfile
       original_path="/tmp/#{file.original_filename}"
       File.rename(f, "/tmp/#{file.original_filename}")
       puts "ORIGINAL PATH #{original_path}"
       new_path="/tmp/#{File.basename(original_path,'.*')}.mp3"
       puts "NEW PATH #{new_path}"
       system("ffmpeg -i #{original_path} -y -vn -ar 44100 -ac 2 -ab 192k -f mp3 #{new_path}")
       new_f = open(new_path)
       media = Media.create(audio:new_f )
       File.delete(original_path) if File.exist?(original_path)
       File.delete(new_path) if File.exist?(new_path)
    when 2 #video
       file.content_type=MIME::Types.type_for(file.original_filename).first.content_type.to_s
       media = Media.create(video:file)
    when 3 #image
       file.content_type=MIME::Types.type_for(file.original_filename).first.content_type.to_s
       puts "CONTENT TYPE #{file.content_type}"
       media = Media.create!(image:file)
       media.save
       puts "IMAGE #{media.image_file_name}"
       puts "SIZE #{media.image_file_size}"
       puts "TYPE #{media.image_content_type}"
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
