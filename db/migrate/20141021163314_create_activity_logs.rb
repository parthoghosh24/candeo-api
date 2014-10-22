class CreateActivityLogs < ActiveRecord::Migration
  def change
    create_table :activity_logs do |t|
      t.integer :user_id
      t.integer :activity_type
      t.json :activity

      t.timestamps
    end
  end
end
