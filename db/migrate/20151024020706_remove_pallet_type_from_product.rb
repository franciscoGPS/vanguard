class RemovePalletTypeFromProduct < ActiveRecord::Migration
  def change
    remove_column :products, :pallet_type_id, :integer
  end
end
