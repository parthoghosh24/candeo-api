class AddReferralTagToContents < ActiveRecord::Migration
  def change
    add_column :contents, :referral_tag, :string
  end
end
