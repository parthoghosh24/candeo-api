# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string(255)
#  username               :string(255)
#  uid                    :string(255)
#  day                    :integer
#  month                  :integer
#  year                   :integer
#  gender                 :string(255)
#  about                  :text
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

# @Partho- This is the main User class
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  has_many :statuses
  has_many :pledges
  has_many :showcases


  def self.show(params)
    user = User.find(params[:id])
    user_response={}
    user_response[:username]=user.username
    user_response[:name]=user.name
    total_inspired=ResponseMap.where(owner_id:params[:id].to_i, is_inspired:1).size
    total_you_got_inspired=ResponseMap.where(user_id:params[:id].to_i, is_inspired:1).size
    user_response[:total_inspired]=total_inspired
    user_response[:total_you_got_inspired]=total_you_got_inspired
    user_response[:inspiritions]=user.statuses
    user_response
  end
end
