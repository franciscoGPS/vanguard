class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :business_name
      t.string :billing_address
      t.string :shipping_address
      t.string :warehose_address
      t.string :tax_id_number
      t.string :chep_id_number
      t.string :bb_number

      t.timestamps null: false
    end
  end
end
