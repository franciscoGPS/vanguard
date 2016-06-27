class ChangeDeliveryPlaceFromSales < ActiveRecord::Migration
  def change
      rename_column :sales, :delivery_place, :delivery_place_id
  end
end
