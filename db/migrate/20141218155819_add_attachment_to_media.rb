class AddAttachmentToMedia < ActiveRecord::Migration
  def self.up
  	add_attachment :media, :attachment
        
  end

  def self.down  	
    remove_attachment :media, :attachment
  end
end
