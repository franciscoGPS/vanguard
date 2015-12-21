class RemoveCountFromShipments < ActiveRecord::Migration
  def change
    remove_column :shipments, :count, :string
  end
end
