class CreateBagTypes < ActiveRecord::Migration
  def change
    create_table :bag_types do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
