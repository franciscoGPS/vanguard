class AddToStateNewValueToShipmentStateChanges < ActiveRecord::Migration
  def change
    add_column :shipment_state_changes, :to_state_new_value, :boolean, :default => false
  end
end
