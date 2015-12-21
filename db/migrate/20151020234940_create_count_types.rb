class CreateCountTypes < ActiveRecord::Migration
  def change
    create_table :count_types do |t|
      t.string :name
      t.integer :product_id

      t.timestamps null: false
    end
  end
end
