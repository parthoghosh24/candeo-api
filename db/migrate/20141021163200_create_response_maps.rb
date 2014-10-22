class CreateResponseMaps < ActiveRecord::Migration
  def change
    create_table :response_maps do |t|
      t.integer :user_id
      t.integer :content_id
      t.integer :is_inspired
      t.integer :did_appreciate

      t.timestamps
    end
  end
end
