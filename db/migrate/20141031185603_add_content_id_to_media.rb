class AddContentIdToMedia < ActiveRecord::Migration
  def change
    add_column :media, :content_id, :integer
  end
end
