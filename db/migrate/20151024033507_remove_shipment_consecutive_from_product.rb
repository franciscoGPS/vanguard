class RemoveShipmentConsecutiveFromProduct < ActiveRecord::Migration
  def change
    remove_column :shipments, :shipment_consecutive, :integer
  end
end
