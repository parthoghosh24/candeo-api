class CreateShowcaseCaps < ActiveRecord::Migration
  def change
    create_table :showcase_caps do |t|
      t.integer :quota
      t.datetime :end_time
      t.datetime :start_time

      t.timestamps
    end
  end
end
