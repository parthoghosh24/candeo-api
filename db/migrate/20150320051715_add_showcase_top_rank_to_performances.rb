class AddShowcaseTopRankToPerformances < ActiveRecord::Migration
  def change
    add_column :performances, :showcase_top_rank, :integer
  end
end
