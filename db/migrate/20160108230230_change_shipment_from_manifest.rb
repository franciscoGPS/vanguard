class ChangeShipmentFromManifest < ActiveRecord::Migration
  def change
    remove_column :manifests, :shipment
    add_column :manifests, :shipment, :string
  end
end
