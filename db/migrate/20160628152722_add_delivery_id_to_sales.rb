class AddDeliveryIdToSales < ActiveRecord::Migration
  def change
    add_column :sales, :delivery_place_id, :integer
  end
end
