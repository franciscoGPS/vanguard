class RemoveWarehoseAddressFromCustomer < ActiveRecord::Migration
  def change
    remove_column :customers, :warehose_address, :string
  end
end
