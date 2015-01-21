class CreateShowcaseQueues < ActiveRecord::Migration
  def change
    create_table :showcase_queues do |t|
      t.integer :showcase_id
      t.boolean :is_deleted
      t.boolean :is_queued

      t.timestamps
    end
  end
end
