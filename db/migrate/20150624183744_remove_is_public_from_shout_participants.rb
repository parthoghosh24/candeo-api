class RemoveIsPublicFromShoutParticipants < ActiveRecord::Migration
  def change
    remove_column :shout_participants, :is_public, :boolean
  end
end
