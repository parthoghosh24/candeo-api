class AddIsCopyrightedToShowcases < ActiveRecord::Migration
  def change
    add_column :showcases, :is_copyrighted, :boolean
  end
end
