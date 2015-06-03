class CreateShoutParticipants < ActiveRecord::Migration
  def change
    create_table :shout_participants do |t|
      t.integer :user_id
      t.integer :shout_id
      t.boolean :is_owner
      t.boolean :is_public

      t.timestamps null: false
    end
  end
end
