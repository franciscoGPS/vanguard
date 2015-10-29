class AddProductColorToShipment < ActiveRecord::Migration
  def change
    add_column :shipments, :product_color, :string
  end
end
