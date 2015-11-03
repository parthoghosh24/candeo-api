# == Schema Information
#
# Table name: media_maps
#
#  id              :integer          not null, primary key
#  media_id        :integer
#  media_url       :string
#  created_at      :datetime
#  updated_at      :datetime
#  attachable_id   :integer
#  attachable_type :string
#  uuid            :string
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
