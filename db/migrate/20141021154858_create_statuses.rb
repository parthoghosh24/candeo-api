class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.integer :mode
      t.integer :user_id

      t.timestamps
    end
  end
end
