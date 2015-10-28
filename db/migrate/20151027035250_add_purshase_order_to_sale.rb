class AddPurshaseOrderToSale < ActiveRecord::Migration
  def change
    add_column :sales, :purshase_order, :boolean, default: false
    add_column :sales, :out_of_packaging, :boolean, default: false
    add_column :sales, :docs_reception, :boolean, default: false
    add_column :sales, :loading_docs, :boolean, default: false
    add_column :sales, :arrived_to_border, :boolean, default: false
    add_column :sales, :out_of_courtyard, :boolean, default: false
    add_column :sales, :documents, :boolean, default: false
    add_column :sales, :mex_customs_mod, :boolean, default: false
    add_column :sales, :us_customs_mod, :boolean, default: false
    add_column :sales, :usda, :boolean, default: false
    add_column :sales, :ramp, :boolean, default: false
    add_column :sales, :fda, :boolean, default: false
    add_column :sales, :hold, :boolean, default: false
    add_column :sales, :hld_qty, :boolean, default: false
    add_column :sales, :arrived_to_warehouse, :boolean, default: false
    add_column :sales, :picked_up_by_cust, :boolean, default: false
    add_column :sales, :bol, :boolean, default: false
  end
end
