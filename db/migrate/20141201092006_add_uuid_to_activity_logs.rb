class AddUuidToActivityLogs < ActiveRecord::Migration
  def change
    add_column :activity_logs, :uuid, :string
  end
end
