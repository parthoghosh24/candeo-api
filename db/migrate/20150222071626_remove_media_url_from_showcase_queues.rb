class RemoveMediaUrlFromShowcaseQueues < ActiveRecord::Migration
  def change
    remove_column :showcase_queues, :media_url, :string
  end
end
