class AddPalletTypeToShipment < ActiveRecord::Migration
  def change
    add_column :shipments, :pallet_type_id, :integer
  end
end
