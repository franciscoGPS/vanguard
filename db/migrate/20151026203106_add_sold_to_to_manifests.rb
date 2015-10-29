class AddSoldToToManifests < ActiveRecord::Migration
  def change
    add_column :manifests, :sold_to, :string, limit: 150
  end
end
