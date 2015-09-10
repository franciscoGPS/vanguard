class CreateBoxTypes < ActiveRecord::Migration
  def change
    create_table :box_types do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
