class AddPackageTypeToShipment < ActiveRecord::Migration
  def change
    add_column :shipments, :package_type_id, :integer
  end
end
