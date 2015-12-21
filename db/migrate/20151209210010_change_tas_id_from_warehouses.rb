class ChangeTasIdFromWarehouses < ActiveRecord::Migration
  def up
    rename_column :warehouses, :tas_id, :tax_id
  end
end
