class AddUserIdToUserMediaMaps < ActiveRecord::Migration
  def change
    add_column :user_media_maps, :user_id, :integer
  end
end
