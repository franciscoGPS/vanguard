class AddPoNumberToShipment < ActiveRecord::Migration
  def change
    add_column :shipments, :po_number, :integer
  end
end
