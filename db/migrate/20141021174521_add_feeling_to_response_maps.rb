class AddFeelingToResponseMaps < ActiveRecord::Migration
  def change
    add_column :response_maps, :feeling, :integer
  end
end
