class AddDeletedAtToPalletType < ActiveRecord::Migration
  def change
    add_column :pallet_types, :deleted_at, :datetime
    add_index :pallet_types, :deleted_at
  end
end
