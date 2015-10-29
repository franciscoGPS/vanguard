class RemoveBoxTypeFromProduct < ActiveRecord::Migration
  def change
    remove_column :products, :box_type_id, :integer
  end
end
