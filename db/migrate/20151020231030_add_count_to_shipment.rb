class AddCountToShipment < ActiveRecord::Migration
  def change
    add_column :shipments, :count, :string
  end
end
