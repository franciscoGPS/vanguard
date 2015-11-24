class AddGreenhouseRefToCustomers < ActiveRecord::Migration
  def change
    add_reference :customers, :greenhouse, index: true, foreign_key: true
  end
end
