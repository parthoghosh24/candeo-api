class AddAppreciationFieldsToResponseMaps < ActiveRecord::Migration
  def change
    add_column :response_maps, :appreciate_rating, :integer
    add_column :response_maps, :appreciate_feedback, :text
  end
end
