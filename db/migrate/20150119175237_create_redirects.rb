class CreateRedirects < ActiveRecord::Migration
  def change
    create_table :redirects do |t|
      t.string :token
      t.string :long_url

      t.timestamps
    end
  end
end
