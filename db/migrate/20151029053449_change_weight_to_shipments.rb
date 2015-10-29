class ChangeWeightToShipments < ActiveRecord::Migration
  def change
    change_column :shipments, :weight, :float
  end
end
