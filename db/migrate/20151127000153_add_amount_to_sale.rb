class AddAmountToSale < ActiveRecord::Migration
  def change
    add_column :sales, :amount, :decimal
  end
end
