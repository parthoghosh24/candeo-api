class AddTagToStatuses < ActiveRecord::Migration
  def change
    add_column :statuses, :tag, :string
  end
end
