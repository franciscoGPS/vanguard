class AddCustomerToShipment < ActiveRecord::Migration
  def change
    add_column :shipments, :customer_id, :integer
  end
end
