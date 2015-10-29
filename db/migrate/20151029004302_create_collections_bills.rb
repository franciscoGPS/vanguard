class CreateCollectionsBills < ActiveRecord::Migration
  def change
    create_table :collections_bills do |t|
      t.integer :sale_id
      t.integer :user_id
      t.integer :invoice_number
      t.integer :shipment_consecutive
      t.integer :po_number
      t.string :payment_terms, limit: 100
      t.timestamp :bol_date
      t.float :total_amt

      t.timestamps null: false
    end
  end
end
