class AddDeletedAtToPackageType < ActiveRecord::Migration
  def change
    add_column :package_types, :deleted_at, :datetime
    add_index :package_types, :deleted_at
  end
end
