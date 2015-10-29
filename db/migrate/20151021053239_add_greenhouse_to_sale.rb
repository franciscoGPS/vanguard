class AddGreenhouseToSale < ActiveRecord::Migration
  def change
    add_column :sales, :greenhouse_id, :integer
  end
end
