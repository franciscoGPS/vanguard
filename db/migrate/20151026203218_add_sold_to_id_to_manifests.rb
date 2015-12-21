class AddSoldToIdToManifests < ActiveRecord::Migration
  def change
    add_column :manifests, :sold_to_id, :integer
  end
end
