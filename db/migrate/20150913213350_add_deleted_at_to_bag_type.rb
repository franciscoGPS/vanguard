class AddDeletedAtToBagType < ActiveRecord::Migration
  def change
    add_column :bag_types, :deleted_at, :datetime
    add_index :bag_types, :deleted_at
  end
end
