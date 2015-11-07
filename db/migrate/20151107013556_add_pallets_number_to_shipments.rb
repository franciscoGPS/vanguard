class AddPalletsNumberToShipments < ActiveRecord::Migration
  def change
    add_column :shipments, :pallets_number, :integer
  end
end
