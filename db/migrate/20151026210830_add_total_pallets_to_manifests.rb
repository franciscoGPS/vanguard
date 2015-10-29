class AddTotalPalletsToManifests < ActiveRecord::Migration
  def change
    add_column :manifests, :total_pallets, :integer, default: 0
  end
end
