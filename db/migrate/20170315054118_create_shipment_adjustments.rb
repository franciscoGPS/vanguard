class CreateShipmentAdjustments < ActiveRecord::Migration
  def change
    create_table :shipment_adjustments do |t|
      t.integer :shipment_id
      t.integer :box_number
      t.float :weight
      t.decimal :price

      t.timestamps null: false
    end
  end
end
