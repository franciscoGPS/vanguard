class RemoveWeightsAvailFromProduct < ActiveRecord::Migration
  def change
    remove_column :products, :weights_avail, :string
  end
end
