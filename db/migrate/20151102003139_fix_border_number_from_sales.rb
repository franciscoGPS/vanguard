class FixBorderNumberFromSales < ActiveRecord::Migration
  def change

    change_table :sales do |t|
      t.rename :arrived_to_order, :arrived_to_border
    end
  end
end



