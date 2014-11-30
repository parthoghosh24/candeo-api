class RenameReviewedToStateInShowcases < ActiveRecord::Migration
  def change
    rename_column :showcases, :reviewed, :state
  end
end
