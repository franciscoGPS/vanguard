class RemoveBagTypeFromProduct < ActiveRecord::Migration
  def change
    remove_column :products, :bag_type_id, :integer
  end
end
