class AddCancelToShipment < ActiveRecord::Migration
  def change
    add_column :shipments, :cancel, :boolean, default: false
  end
end
