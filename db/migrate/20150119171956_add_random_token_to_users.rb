class AddRandomTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :random_token, :integer
  end
end
