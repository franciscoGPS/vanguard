class ChangePoNuumberFromShipments < ActiveRecord::Migration
  def change
    change_column :shipments, :po_number,  :string
  end
end
