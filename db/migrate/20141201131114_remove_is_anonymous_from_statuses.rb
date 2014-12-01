class RemoveIsAnonymousFromStatuses < ActiveRecord::Migration
  def change
    remove_column :statuses, :is_anonymous, :boolean
  end
end
