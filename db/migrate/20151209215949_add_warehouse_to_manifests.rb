class AddWarehouseToManifests < ActiveRecord::Migration
  def change
    add_reference :manifests, :warehouse, index: true, foreign_key: true
  end
end
