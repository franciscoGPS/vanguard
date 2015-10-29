class RemoveProductColorFromShipment < ActiveRecord::Migration
  def change
    remove_column :shipments, :product_color, :integer
  end
end
