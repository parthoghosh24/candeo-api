class AddResponseCountsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :total_appreciations, :integer
    add_column :users, :total_inspires, :integer
  end
end
