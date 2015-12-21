class AddAttachmentLogoToGreenhouses < ActiveRecord::Migration
  def self.up
    change_table :greenhouses do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :greenhouses, :logo
  end
end
