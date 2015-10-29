class RemoveManifestFromSales < ActiveRecord::Migration
  def change
    remove_column :sales, :manifest, :text
  end
end
