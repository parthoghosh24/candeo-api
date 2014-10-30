class AddContentTypeToResponseMaps < ActiveRecord::Migration
  def change
    add_column :response_maps, :content_type, :integer
  end
end
