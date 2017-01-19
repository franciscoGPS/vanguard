class AddRaysScanToSale < ActiveRecord::Migration
  def change
    add_column :sales, :rays_scan, :boolean
  end
end
