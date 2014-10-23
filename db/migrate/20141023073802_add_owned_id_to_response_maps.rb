class AddOwnedIdToResponseMaps < ActiveRecord::Migration
  def change
    add_column :response_maps, :owner_id, :integer
  end
end
