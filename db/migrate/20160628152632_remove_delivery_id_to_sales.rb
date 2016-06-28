class RemoveDeliveryIdToSales < ActiveRecord::Migration
  def change
  	remove_column :sales, :delivery_place_id
  end
end
