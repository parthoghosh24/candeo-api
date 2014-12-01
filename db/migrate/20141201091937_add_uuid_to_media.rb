class AddUuidToMedia < ActiveRecord::Migration
  def change
    add_column :media, :uuid, :string
  end
end
