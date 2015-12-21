class AddManifestNumberToManifest < ActiveRecord::Migration
  def change
    add_column :manifests, :manifest_number, :integer, default: 0
  end
end
