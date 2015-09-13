class CreatePalletTypes < ActiveRecord::Migration
  def change
    create_table :pallet_types do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
