class AddSwitchesToCollectionsBills < ActiveRecord::Migration
  def change
    add_column :collections_bills, :show_color, :boolean, :null => false, :default => false
    add_column :collections_bills, :show_count_type, :boolean, :null => false, :default => false
    add_column :collections_bills, :show_pkg_type, :boolean, :null => false, :default => false
    add_column :collections_bills, :show_bag_type, :boolean, :null => false, :default => false
    add_column :collections_bills, :show_plu, :boolean, :null => false, :default => false
  end
end
