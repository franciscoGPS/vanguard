class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.string :season
      t.date :departure_date
      t.date :arrival_date
      t.text :manifest
      t.text :annotation
      t.text :comment

      t.timestamps null: false
    end
  end
end
