class RenameShipmentFromManifest < ActiveRecord::Migration
  def change
    rename_column :manifests, :shipment, :ship_number
  end
end
