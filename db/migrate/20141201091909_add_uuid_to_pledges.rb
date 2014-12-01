class AddUuidToPledges < ActiveRecord::Migration
  def change
    add_column :pledges, :uuid, :string
  end
end
