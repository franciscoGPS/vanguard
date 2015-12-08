class AddDeletedAtToCountType < ActiveRecord::Migration
  def change
    add_column :count_types, :deleted_at, :datetime
    add_index :count_types, :deleted_at
  end
end
