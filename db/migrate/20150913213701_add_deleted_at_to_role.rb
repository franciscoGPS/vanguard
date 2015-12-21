class AddDeletedAtToRole < ActiveRecord::Migration
  def change
    add_column :roles, :deleted_at, :datetime
    add_index :roles, :deleted_at
  end
end
