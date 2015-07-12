class AddUuidIndexToContents < ActiveRecord::Migration
  def change
    add_index :contents, :uuid
  end
end
