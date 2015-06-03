class CreateShoutDiscussions < ActiveRecord::Migration
  def change
    create_table :shout_discussions do |t|
      t.integer :shout_id
      t.integer :user_id
      t.json :discussion

      t.timestamps null: false
    end
  end
end
