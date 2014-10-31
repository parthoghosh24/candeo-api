class AddFieldsToMedia < ActiveRecord::Migration
  def self.up
    add_attachment :media, :image
    add_attachment :media, :video
    add_attachment :media, :audio
    add_attachment :media, :doc
  end

  def self.down
    remove_attachment :media, :image
    remove_attachment :media, :video
    remove_attachment :media, :audio
    remove_attachment :media, :doc
  end
end
