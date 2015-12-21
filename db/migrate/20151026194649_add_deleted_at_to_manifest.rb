class AddDeletedAtToManifest < ActiveRecord::Migration
  def change
    add_column :manifests, :deleted_at, :date
  end
end
