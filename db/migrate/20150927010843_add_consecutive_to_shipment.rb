class AddConsecutiveToShipment < ActiveRecord::Migration
  def change
    add_column :shipments, :shipment_consecutive, :integer
  end
end
