class AddDeletedAtToGreenhouses < ActiveRecord::Migration
  def change
    add_column :greenhouses, :deleted_at, :datetime
    add_index :greenhouses, :deleted_at
  end
end
