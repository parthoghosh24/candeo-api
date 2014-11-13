class AddActivityLevelToActivityLogs < ActiveRecord::Migration
  def change
    add_column :activity_logs, :activity_level, :integer
  end
end
