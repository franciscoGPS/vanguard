class AddPriceToShipment < ActiveRecord::Migration
  def change
    add_column :shipments, :price, :decimal
  end
end
