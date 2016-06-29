class AddLeyendToManifests < ActiveRecord::Migration
  def change
    add_column :manifests, :leyend, :text
  end
end
