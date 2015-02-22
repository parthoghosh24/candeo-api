class RemoveResponseCountsFromShowcaseQueues < ActiveRecord::Migration
  def change
    remove_column :showcase_queues, :total_appreciations, :integer
    remove_column :showcase_queues, :total_skips, :integer
  end
end
