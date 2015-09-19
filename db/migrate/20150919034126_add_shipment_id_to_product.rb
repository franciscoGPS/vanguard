class AddShipmentIdToProduct < ActiveRecord::Migration
  def change
    add_column :products, :shipment_id, :integer
    add_index :products, :shipment_id
  end
end
