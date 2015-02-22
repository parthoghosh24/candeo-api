class AddResponseFieldsToShowcaseQueues < ActiveRecord::Migration
  def change
    add_column :showcase_queues, :total_appreciations, :integer
    add_column :showcase_queues, :total_skips, :integer
  end
end
