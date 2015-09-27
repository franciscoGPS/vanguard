class AddDeletedToShipment < ActiveRecord::Migration
  def change
    add_column :shipments, :deleted_at, :datetime
    add_index :shipments, :deleted_at
  end
end
