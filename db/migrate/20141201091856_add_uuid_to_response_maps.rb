class AddUuidToResponseMaps < ActiveRecord::Migration
  def change
    add_column :response_maps, :uuid, :string
  end
end
