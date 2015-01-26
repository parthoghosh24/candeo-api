class RemoveIsQueuedFromShowcaseQueues < ActiveRecord::Migration
  def change
    remove_column :showcase_queues, :is_queued, :boolean
  end
end
