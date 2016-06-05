class AddDeletedAtToDeliveryPlaces < ActiveRecord::Migration
  def change
    add_column :delivery_places, :deleted_at, :timestamp
  end
end
