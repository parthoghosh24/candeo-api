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

# @partho - Candeo Global Media Class. Whatever files get uploaded, this is the class which handles them.
# media_type -> 1:audio 2:video 3:image 4:Book
class Media < ActiveRecord::Base
  after_create :generate_uuid  
  has_attached_file :attachment,
                    :storage => :fog,
                    :fog_credentials => "#{Rails.root}/config/gce.yml",
                    :fog_directory => FOG_CONF['fog_directory']

  validates_attachment_content_type :attachment, :content_type => ['application/octet-stream','image/jpeg','image/jpg','image/png','video/mp4','video/3gpp','audio/mp3','audio/mpeg', 'application/mp4','application/epub+zip']
  do_not_validate_attachment_file_type :attachment



  #has_attached_file :doc #Need to be dealt in second release
  #validates_attachment_content_type :image, :content_type => [ 'application/epub+zip', 'application/pdf',  'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document']

  def self.purge
    list=[]
    Media.all.each do |media|
      list.push(media.id) if !MediaMap.exists?(media_id:media.id)
    end         
    Media.delete(list) if list.size > 0
  end

  def self.upload(file, type)
    media=nil
    original_path=nil
    new_path=nil
    new_file=nil
    case type
    when 1 #audio
       f = file.tempfile
       puts "FILE NAME IS #{file.original_filename}"
       puts "FILE CONTAINS MP3 #{file.original_filename.include?".mp3"}"       
       if !file.original_filename.include?".mp3"
           original_path="/tmp/#{file.original_filename}"
           File.rename(f, "/tmp/#{file.original_filename}")
           puts "ORIGINAL PATH #{original_path}"
           new_path="/tmp/#{File.basename(original_path,'.*')}.mp3"
           puts "NEW PATH #{new_path}"
           system("ffmpeg -i #{original_path} -y -vn -ar 44100 -ac 2 -ab 192k -f mp3 #{new_path}")
           new_f = open(new_path)
           new_file=new_f
           puts "New File name is #{File.basename(new_file)}"
       else
        file.content_type=MIME::Types.type_for(file.original_filename).first.content_type.to_s
        puts "CONTENT TYPE #{file.content_type}"
        new_file=file
       end       

    when 2 #video
       file.content_type=MIME::Types.type_for(file.original_filename).first.content_type.to_s
       new_file=file
       puts "CONTENT TYPE #{file.content_type}"

    when 3 #image
       file.content_type=MIME::Types.type_for(file.original_filename).first.content_type.to_s
       new_file=file
       puts "CONTENT TYPE #{file.content_type}"

     when 4 #book
        file.content_type=MIME::Types.type_for(file.original_filename).first.content_type.to_s
        new_file=file
        puts "CONTENT TYPE #{file.content_type}"
    end
    media = Media.create!(attachment:new_file)
    File.delete(original_path) if original_path && File.exist?(original_path)
    File.delete(new_path) if new_path && File.exist?(new_path)
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
