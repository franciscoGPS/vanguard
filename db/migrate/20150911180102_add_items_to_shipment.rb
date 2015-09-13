class AddItemsToShipment < ActiveRecord::Migration
  def change
    add_column :shipments, :greenhouse_id, :integer
    add_column :shipments, :shipment_consecutive, :integer
    add_column :shipments, :departure_date, :datetime
    add_column :shipments, :pallets_number, :integer
    add_column :shipments, :comments, :text

    add_index :shipments, :greenhouse_id
  end
end
