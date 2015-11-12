class AddCustomerToCollectionsBills < ActiveRecord::Migration
  def change
    add_column :collections_bills, :customer_id, :integer
  end
end
