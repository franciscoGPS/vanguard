class RemoveStateFromSale < ActiveRecord::Migration
  def change
    remove_column :sales, :state, :string
  end
end
