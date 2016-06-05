class CreateDeliveryPlaces < ActiveRecord::Migration
  def change
    create_table :delivery_places do |t|
      t.string :name
    end
  end
end
