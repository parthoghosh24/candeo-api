class RemoveFieldsFromShowcaseQueues < ActiveRecord::Migration
  def change
    remove_column :showcase_queues, :name, :string
    remove_column :showcase_queues, :user_avatar_url, :string
    remove_column :showcase_queues, :bg_url, :string
  end
end
