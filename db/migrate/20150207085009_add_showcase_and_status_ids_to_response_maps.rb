class AddShowcaseAndStatusIdsToResponseMaps < ActiveRecord::Migration
  def change
    add_column :response_maps, :showcase_id, :integer
    add_column :response_maps, :status_id, :integer
  end
end
