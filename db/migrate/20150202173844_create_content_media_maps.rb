class CreateContentMediaMaps < ActiveRecord::Migration
  def change
    create_table :content_media_maps do |t|

      t.timestamps
    end
  end
end
