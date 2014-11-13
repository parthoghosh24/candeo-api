class AddUserIdToShowcases < ActiveRecord::Migration
  def change
    add_column :showcases, :user_id, :integer
  end
end
