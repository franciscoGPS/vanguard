class AddDeliveryPlaceToSale < ActiveRecord::Migration
  def change
    add_column :sales, :delivery_place, :string
  end
end
