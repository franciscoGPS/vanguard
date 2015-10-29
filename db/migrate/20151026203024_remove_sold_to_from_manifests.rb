class RemoveSoldToFromManifests < ActiveRecord::Migration
  def change
    remove_column :manifests, :sold_to, :integer
  end
end
