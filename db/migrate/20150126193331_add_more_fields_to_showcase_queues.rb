class AddMoreFieldsToShowcaseQueues < ActiveRecord::Migration
  def change
    add_column :showcase_queues, :name, :string
    add_column :showcase_queues, :title, :string
    add_column :showcase_queues, :user_avatar_url, :string
    add_column :showcase_queues, :total_appreciations, :integer
    add_column :showcase_queues, :total_skips, :integer
    add_column :showcase_queues, :bg_url, :string
    add_column :showcase_queues, :media_url, :string
    add_column :showcase_queues, :media_type, :integer
  end
end
