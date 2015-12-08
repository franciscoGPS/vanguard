class AddCountTypeToShipments < ActiveRecord::Migration
  def change
    add_reference :shipments, :count_type, index: true, foreign_key: true
  end
end
