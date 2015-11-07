class AddMexCustomBrokerFromManifest < ActiveRecord::Migration
  def change
    add_column :manifests, :mex_custom_broker, :string
    add_column :manifests, :usa_custom_broker, :string
  end
end
