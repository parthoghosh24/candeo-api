class RemoveContentTypeFromResponseMaps < ActiveRecord::Migration
  def change
    remove_column :response_maps, :content_type, :integer
  end
end
