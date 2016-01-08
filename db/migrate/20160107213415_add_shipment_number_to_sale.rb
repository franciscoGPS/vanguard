class AddShipmentNumberToSale < ActiveRecord::Migration
  def change
    add_column :sales, :shipment, :string
    add_index :sales, :shipment, :unique => true
  end
end
