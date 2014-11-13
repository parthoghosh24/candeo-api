class AddUserIdToPledges < ActiveRecord::Migration
  def change
    add_column :pledges, :user_id, :integer
  end
end
