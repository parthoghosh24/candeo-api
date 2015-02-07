class AddContentIdToContentMediaMaps < ActiveRecord::Migration
  def change
    add_column :content_media_maps, :content_id, :integer
  end
end
