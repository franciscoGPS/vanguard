class RemoveCustomerFromSale < ActiveRecord::Migration
  def change
    remove_column :sales, :customer_id, :integer
  end
end
