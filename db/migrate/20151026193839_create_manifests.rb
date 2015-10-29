class CreateManifests < ActiveRecord::Migration
  def change
    create_table :manifests do |t|
      t.integer :sale_id
      t.date :date
      t.integer :sold_to
      t.text :sent_to
      t.string :custom_broker, limit: 220
      t.string :carrier, limit: 200
      t.string :driver, limit: 80
      t.string :truck, limit: 15
      t.string :truck_licence_plate, limit: 15
      t.string :trailer_num, limit: 15
      t.string :trailer_num_lp, limit: 15
      t.string :stamp, limit: 40
      t.string :thermograph, limit: 15
      t.integer :purshase_order
      t.integer :shipment
      t.string :delivery_person, limit: 80
      t.string :person_receiving, limit: 80
      t.integer :trailer_size
      t.string :caat, limit: 6
      t.string :alpha, limit: 15
      t.string :fda_num, limit: 20
      t.integer :pallet_number
      t.text :comments

      t.timestamps null: false
    end
  end
end
