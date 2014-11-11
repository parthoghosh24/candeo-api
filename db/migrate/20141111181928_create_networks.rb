class CreateNetworks < ActiveRecord::Migration
  def change
    create_table :networks do |t|
      t.integer :follower_id
      t.integer :followee_id
      t.integer :is_friend
      t.integer :is_blocked

      t.timestamps
    end
  end
end
