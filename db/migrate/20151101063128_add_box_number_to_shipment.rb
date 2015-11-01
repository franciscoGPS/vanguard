class AddBoxNumberToShipment < ActiveRecord::Migration
  def change
    add_column :shipments, :box_number, :integer
  end
end
