class AddBoxTypeToShipment < ActiveRecord::Migration
  def change
    add_column :shipments, :box_type_id, :integer
  end
end
