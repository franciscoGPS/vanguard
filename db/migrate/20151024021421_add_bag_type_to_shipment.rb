class AddBagTypeToShipment < ActiveRecord::Migration
  def change
    add_column :shipments, :bag_type_id, :integer
  end
end
