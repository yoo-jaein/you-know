class AddAttachmentAudioToComments < ActiveRecord::Migration
  def self.up
    change_table :comments do |t|
      t.attachment :audio
    end
  end

  def self.down
    remove_attachment :comments, :audio
  end
end
