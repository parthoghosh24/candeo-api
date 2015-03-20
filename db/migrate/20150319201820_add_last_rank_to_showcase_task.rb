class AddLastRankToShowcaseTask < ActiveRecord::Migration
  def change
    add_column :showcase_tasks, :last_rank, :integer
  end
end
