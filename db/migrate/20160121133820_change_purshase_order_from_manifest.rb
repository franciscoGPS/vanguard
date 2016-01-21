class ChangePurshaseOrderFromManifest < ActiveRecord::Migration
  def change
    change_column :manifests, :purshase_order,  :string
    rename_column :manifests, :purshase_order,  :po_number
    change_column :collections_bills, :po_number,  :string
  end
end
