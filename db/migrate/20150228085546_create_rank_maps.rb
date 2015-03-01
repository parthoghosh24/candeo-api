class CreateRankMaps < ActiveRecord::Migration
  def change
    create_table :rank_maps do |t|
      t.integer :user_id
      t.integer :rank
      t.integer :count

      t.timestamps
    end
  end
end
