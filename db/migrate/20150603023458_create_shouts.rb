class CreateShouts < ActiveRecord::Migration
  def change
    create_table :shouts do |t|
      t.text :body
      t.integer :user_id
      t.boolean :is_public

      t.timestamps null: false
    end
  end
end
