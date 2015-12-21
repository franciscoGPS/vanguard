class AddDeletedAtToSales < ActiveRecord::Migration
  def change
    add_column :sales, :deleted_at, :datetime
    add_index :sales, :deleted_at
  end
end
