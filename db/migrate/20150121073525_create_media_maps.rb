class CreateMediaMaps < ActiveRecord::Migration
  def change
    create_table :media_maps do |t|
      t.integer :media_id
      t.integer :type_id
      t.string :type_name
      t.string :media_url

      t.timestamps
    end
  end
end
