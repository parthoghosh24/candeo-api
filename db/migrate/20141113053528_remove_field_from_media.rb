class RemoveFieldFromMedia < ActiveRecord::Migration
  def change
    remove_column :media, :name, :string
    remove_column :media, :mime_type, :string
  end
end
