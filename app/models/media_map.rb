# == Schema Information
#
# Table name: media_maps
#
#  id              :integer          not null, primary key
#  media_id        :integer
#  media_url       :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  attachable_id   :integer
#  attachable_type :string(255)
#  uuid            :string(255)
#

class MediaMap < ActiveRecord::Base
	belongs_to :attachable, polymorphic: true
	belongs_to :media

	private

	  def generate_uuid
	        token = SecureRandom.hex(20)
	        while(self.class.exists?(uuid:token)) do
	          token = SecureRandom.hex(20)
	        end
	        self.update(uuid:token)
	  end
end
