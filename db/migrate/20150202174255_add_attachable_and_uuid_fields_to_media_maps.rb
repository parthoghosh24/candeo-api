class AddAttachableAndUuidFieldsToMediaMaps < ActiveRecord::Migration
  def change
    add_column :media_maps, :attachable_id, :integer
    add_column :media_maps, :attachable_type, :string
    add_column :media_maps, :uuid, :string
  end
end
