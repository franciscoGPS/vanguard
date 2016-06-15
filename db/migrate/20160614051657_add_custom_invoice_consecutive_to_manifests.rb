class AddCustomInvoiceConsecutiveToManifests < ActiveRecord::Migration
  def change
    add_column :manifests, :custom_invoice_id, :integer
  end
end
