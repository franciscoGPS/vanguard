class RemovePalletNumberFromManifests < ActiveRecord::Migration
  def change
    remove_column :manifests, :pallet_number, :integer
  end
end
