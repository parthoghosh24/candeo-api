class RemoveFieldsFromPerformances < ActiveRecord::Migration
  def change
    remove_column :performances, :showcase_bg_url, :string
    remove_column :performances, :showcase_media_url, :string
    remove_column :performances, :showcase_user_name, :string
    remove_column :performances, :showcase_user_avatar_url, :string
  end
end
