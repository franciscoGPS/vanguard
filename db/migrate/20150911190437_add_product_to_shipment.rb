class AddProductToShipment < ActiveRecord::Migration
  def change
    add_column :shipments, :product_id, :integer
  end
end
