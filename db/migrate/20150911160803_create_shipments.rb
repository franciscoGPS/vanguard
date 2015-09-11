class CreateShipments < ActiveRecord::Migration
  def change
    create_table :shipments do |t|
      t.string :name
      t.date :start_at

      t.timestamps null: false
    end
  end
end
