class CreateWarehouses < ActiveRecord::Migration
  def change
    create_table :warehouses do |t|
      t.string :name
      t.string :address
      t.string :tas_id
      t.references :greenhouse, index: true, foreign_key: true
      t.date :deleted_at

      t.timestamps null: false
    end
  end
end
