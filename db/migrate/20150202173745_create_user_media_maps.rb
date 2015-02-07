class CreateUserMediaMaps < ActiveRecord::Migration
  def change
    create_table :user_media_maps do |t|

      t.timestamps
    end
  end
end
