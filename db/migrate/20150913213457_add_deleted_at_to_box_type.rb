class AddDeletedAtToBoxType < ActiveRecord::Migration
  def change
    add_column :box_types, :deleted_at, :datetime
    add_index :box_types, :deleted_at
  end
end
