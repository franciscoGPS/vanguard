class AddRevisionToSale < ActiveRecord::Migration
  def change
    add_column :sales, :revision, :boolean
  end
end
