class AddDeletedAtToCollectionsBill < ActiveRecord::Migration
  def change
    add_column :collections_bills, :deleted_at, :timestamp
  end
end
