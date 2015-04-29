class AddIsShowcaseArchivedToPerformances < ActiveRecord::Migration
  def change
    add_column :performances, :is_showcase_archived, :boolean
  end
end
