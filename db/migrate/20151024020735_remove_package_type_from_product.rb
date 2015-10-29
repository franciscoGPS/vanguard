class RemovePackageTypeFromProduct < ActiveRecord::Migration
  def change
    remove_column :products, :package_type_id, :integer
  end
end
