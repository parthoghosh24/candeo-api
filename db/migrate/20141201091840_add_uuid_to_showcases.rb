class AddUuidToShowcases < ActiveRecord::Migration
  def change
    add_column :showcases, :uuid, :string
  end
end
