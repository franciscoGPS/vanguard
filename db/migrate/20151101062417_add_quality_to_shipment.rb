class AddQualityToShipment < ActiveRecord::Migration
  def change
    add_column :shipments, :quality, :string, limit: 30
  end
end
