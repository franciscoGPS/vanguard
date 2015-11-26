class AddProductColorToSale < ActiveRecord::Migration
  def change
    add_column :sales, :product_color, :string
  end
end
