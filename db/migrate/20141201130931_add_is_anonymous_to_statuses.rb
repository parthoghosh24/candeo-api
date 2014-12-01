class AddIsAnonymousToStatuses < ActiveRecord::Migration
  def change
    add_column :statuses, :is_anonymous, :boolean
  end
end
