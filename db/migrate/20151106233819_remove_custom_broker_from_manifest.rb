class RemoveCustomBrokerFromManifest < ActiveRecord::Migration
  def change
    remove_column :manifests, :custom_broker, :string
  end
end
