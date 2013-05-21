class ChangeAttachmentNameEventsAvatarToPicture < ActiveRecord::Migration
  def self.up
    remove_attachment :events, :avatar
    add_attachment :events, :picture
  end

  def down
  end
end
