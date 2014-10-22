class AddFieldToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :username, :string
    add_column :users, :uid, :string
    add_column :users, :day, :integer
    add_column :users, :month, :integer
    add_column :users, :year, :integer
    add_column :users, :gender, :string
    add_column :users, :about, :text
  end
end
