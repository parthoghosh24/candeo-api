class RenameFeelingToInspiritionFeelingInResponseMaps < ActiveRecord::Migration
  def change
      rename_column :response_maps, :feeling, :inspirition_feeling
  end
end
