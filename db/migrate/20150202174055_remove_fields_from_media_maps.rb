class RemoveFieldsFromMediaMaps < ActiveRecord::Migration
  def change
    remove_column :media_maps, :type_id, :integer
    remove_column :media_maps, :type_name, :string
  end
end
