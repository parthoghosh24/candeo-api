class AddReviewedToShowcases < ActiveRecord::Migration
  def change
    add_column :showcases, :reviewed, :integer
  end
end
