class CreateShipmentStateChanges < ActiveRecord::Migration
  def change
    create_table :shipment_state_changes do |t|
      t.integer :sale_id
      t.timestamp :change_time
      t.integer :from_state
      t.integer :to_state
      t.timestamp :deleted_at
      t.integer :user_id_changed


      t.timestamps null: false
    end
  end
end
