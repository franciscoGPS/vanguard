class AddCustomerToSale < ActiveRecord::Migration
  def change
    add_column :sales, :customer_id, :integer
  end
end
