# == Schema Information
#
# Table name: notifications
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Notification < ActiveRecord::Base
	def self.init
		puts "Notification system initiated"
		if !Rpush::Gcm::App.find_by_name("candeo-gcm")
			app = Rpush::Gcm::App.new
			app.name = "candeo-gcm"
			app.environment = Rails.env
			app.auth_key=DATABASE_CONF['gcm_key']
			app.connections=1
			app.save!	 
		end
	end

	def self.send(message, registration_ids)
		notification = Rpush::Gcm::Notification.new
    	notification.app = Rpush::Gcm::App.find_by_name("candeo-gcm")
    	notification.registration_ids = registration_ids
    	notification.data = { message: message }
    	notification.save!
	end
end
