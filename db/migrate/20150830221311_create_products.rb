class CreateProducts < ActiveRecord::Migration
  def change

    create_table :products do |t|
      t.string :name
      t.references :greenhouse
      t.references :package_type
      t.references :box_type
      t.string :weights_avail
      t.references :pallet_type
      t.references :bag_type
      t.boolean :active

      t.timestamps null: false
    end
    add_index :products, :package_type_id
    add_index :products, :box_type_id
    add_index :products, :pallet_type_id
    add_index :products, :bag_type_id 
    add_index :products, :greenhouse_id

  end
end
