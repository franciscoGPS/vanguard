class ChangeHldQtyFromSale < ActiveRecord::Migration
  def change
    remove_column :sales, :hld_qty
    add_column :sales, :hld_qty, :integer, default: 0
  end
end
