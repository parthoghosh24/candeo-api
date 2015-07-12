class AddShortIdToContents < ActiveRecord::Migration
  def change
    add_column :contents, :short_id, :string
  end
end
