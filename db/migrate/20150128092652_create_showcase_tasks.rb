class CreateShowcaseTasks < ActiveRecord::Migration
  def change
    create_table :showcase_tasks do |t|
      t.string :cron
      t.integer :content_limit
      t.datetime :last_timestamp
      t.integer :last_timestamp_epoch

      t.timestamps
    end
  end
end
