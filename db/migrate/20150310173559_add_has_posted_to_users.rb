class AddHasPostedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :has_posted, :boolean
  end
end
