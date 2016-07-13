class AddWarehouseIdToSale < ActiveRecord::Migration
  def change
    add_column :sales, :warehouse_id, :integer
  end
end
