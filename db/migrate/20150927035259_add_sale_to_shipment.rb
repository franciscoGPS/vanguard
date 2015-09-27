class AddSaleToShipment < ActiveRecord::Migration
  def change
    add_column :shipments, :sale_id, :integer
  end
end
