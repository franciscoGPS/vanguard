class AddDeletedAtToColor < ActiveRecord::Migration
  def change
    add_column :colors, :deleted_at, :timestamp
  end
end
