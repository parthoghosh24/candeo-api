class RemoveContentIdFromMedia < ActiveRecord::Migration
  def change
    remove_column :media, :content_id, :integer
  end
end
