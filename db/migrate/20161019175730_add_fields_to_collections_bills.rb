class AddFieldsToCollectionsBills < ActiveRecord::Migration
  def change
    add_column :collections_bills, :label_one, :string, :null => false, :default => ''
    add_column :collections_bills, :label_two, :string, :null => false, :default => ''
    add_column :collections_bills, :bill_of_lading, :string, :null => false, :default => ''
    add_column :collections_bills, :thermograph, :string, :null => false, :default => ''
    add_column :collections_bills, :footer_one, :text, :null => false, :default => ''
    add_column :collections_bills, :footer_two, :text, :null => false, :default => ''
  end
end
