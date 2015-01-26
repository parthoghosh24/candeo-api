class CreatePerformances < ActiveRecord::Migration
  def change
    create_table :performances do |t|
      t.integer :showcase_id
      t.string :showcase_title
      t.string :showcase_bg_url
      t.string :showcase_media_url
      t.integer :showcase_media_type
      t.integer :showcase_total_appreciations
      t.integer :showcase_total_skips
      t.string :showcase_user_name
      t.string :showcase_user_avatar_url
      t.datetime :showcase_created_at
      t.integer :showcase_rank
      t.decimal :showcase_score

      t.timestamps
    end
  end
end
