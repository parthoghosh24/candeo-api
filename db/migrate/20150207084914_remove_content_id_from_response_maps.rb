class RemoveContentIdFromResponseMaps < ActiveRecord::Migration
  def change
    remove_column :response_maps, :content_id, :integer
  end
end
