class AddIndexShortIdsToContents < ActiveRecord::Migration
  def change
      add_index :contents, :short_id
  end
end
