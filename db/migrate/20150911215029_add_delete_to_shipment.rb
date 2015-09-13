class AddDeleteToShipment < ActiveRecord::Migration
  def change
    add_column :shipments, :deleted_at, :datetime
  end
end
