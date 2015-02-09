class RenameFieldsInResponseMaps < ActiveRecord::Migration
  def change
      rename_column :response_maps, :appreciation_reaction, :appreciation_response
      rename_column :response_maps, :did_appreciate, :has_appreciated
  end
end
