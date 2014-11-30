class AddApprecitionReactionToResponseMaps < ActiveRecord::Migration
  def change
    add_column :response_maps, :appreciation_reaction, :json
  end
end
