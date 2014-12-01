class AddUuidToContents < ActiveRecord::Migration
  def change
    add_column :contents, :uuid, :string
  end
end
