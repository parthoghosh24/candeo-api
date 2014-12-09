class RemoveMediaIdFromContents < ActiveRecord::Migration
  def change
    remove_column :contents, :media_id, :integer
  end
end
