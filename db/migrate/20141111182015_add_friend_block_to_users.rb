class AddFriendBlockToUsers < ActiveRecord::Migration
  def change
    add_column :users, :friend_block, :integer
  end
end
