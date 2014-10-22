class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.integer :type
      t.string :name
      t.string :mime_type

      t.timestamps
    end
  end
end
