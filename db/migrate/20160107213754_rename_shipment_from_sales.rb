class RenameShipmentFromSales < ActiveRecord::Migration
  def change
    rename_column :sales, :shipment, :ship_number
  end
end
