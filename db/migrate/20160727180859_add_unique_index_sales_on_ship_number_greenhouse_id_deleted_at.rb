class AddUniqueIndexSalesOnShipNumberGreenhouseIdDeletedAt < ActiveRecord::Migration
  def change
    add_index(:sales, [:greenhouse_id, :deleted_at, :ship_number], unique: true)
  end
end
