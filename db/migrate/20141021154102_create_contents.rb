class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.text :description
      t.integer :media_id

      t.timestamps
    end
  end
end
