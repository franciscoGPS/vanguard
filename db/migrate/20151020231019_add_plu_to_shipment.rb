class AddPluToShipment < ActiveRecord::Migration
  def change
    add_column :shipments, :plu, :boolean
  end
end
