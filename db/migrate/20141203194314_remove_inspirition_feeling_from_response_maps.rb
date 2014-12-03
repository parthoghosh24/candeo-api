class RemoveInspiritionFeelingFromResponseMaps < ActiveRecord::Migration
  def change
    remove_column :response_maps, :inspirition_feeling, :integer
  end
end
