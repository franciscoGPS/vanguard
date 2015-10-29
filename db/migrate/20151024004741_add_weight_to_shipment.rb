class AddWeightToShipment < ActiveRecord::Migration
  def change
    add_column :shipments, :weight, :integer
  end
end
