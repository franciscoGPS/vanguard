class AddProformaInvoiceToCollectionsBills < ActiveRecord::Migration
  def change
    add_column :collections_bills, :proforma_invoice, :string
  end
  #execute "SELECT setval('customers_id_seq', 1000);"
end
