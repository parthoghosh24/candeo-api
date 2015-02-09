class AddSkipResponsesToResponseMaps < ActiveRecord::Migration
  def change
    add_column :response_maps, :has_skipped, :boolean
    add_column :response_maps, :skip_response, :json
  end
end
