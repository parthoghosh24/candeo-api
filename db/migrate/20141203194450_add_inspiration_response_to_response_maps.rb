class AddInspirationResponseToResponseMaps < ActiveRecord::Migration
  def change
    add_column :response_maps, :inspiration_response, :json
  end
end
