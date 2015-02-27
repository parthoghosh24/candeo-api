class AddIsCopyrightedToShowcaseQueues < ActiveRecord::Migration
  def change
    add_column :showcase_queues, :is_copyrighted, :boolean
  end
end
