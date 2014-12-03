class RemoveFieldsFromResponseMaps < ActiveRecord::Migration
  def change
    remove_column :response_maps, :appreciate_rating, :integer
    remove_column :response_maps, :appreciate_feedback, :text
  end
end
