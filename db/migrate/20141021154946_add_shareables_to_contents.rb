class AddShareablesToContents < ActiveRecord::Migration
  def change
    add_column :contents, :shareable_type, :string
    add_column :contents, :shareable_id, :integer
  end
end
