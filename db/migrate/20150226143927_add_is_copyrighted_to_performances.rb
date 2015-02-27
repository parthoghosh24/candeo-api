class AddIsCopyrightedToPerformances < ActiveRecord::Migration
  def change
    add_column :performances, :is_showcase_copyrighted, :boolean
  end
end
