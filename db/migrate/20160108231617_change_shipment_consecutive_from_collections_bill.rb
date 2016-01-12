class ChangeShipmentConsecutiveFromCollectionsBill < ActiveRecord::Migration
  def change
    remove_column :collections_bills, :shipment_consecutive
    add_column :collections_bills, :ship_number, :string
  end
end
