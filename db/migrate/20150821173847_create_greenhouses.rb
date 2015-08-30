class CreateGreenhouses < ActiveRecord::Migration
  def change
    create_table :greenhouses do |t|
      t.string :business_name
      t.text :fiscal_address
      t.text :greenhouse_address
      t.string :rfc
      t.string :category

      t.timestamps null: false
    end
  end
end
