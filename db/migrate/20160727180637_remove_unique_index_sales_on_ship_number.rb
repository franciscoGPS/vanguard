class RemoveUniqueIndexSalesOnShipNumber < ActiveRecord::Migration
  def change
    remove_index(:sales, name: :index_sales_on_ship_number)
  end
end
