class AddAttachmentLogoToCustomers < ActiveRecord::Migration
  def self.up
    change_table :customers do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :customers, :logo
  end
end

