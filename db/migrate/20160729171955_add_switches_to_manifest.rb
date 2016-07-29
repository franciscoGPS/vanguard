class AddSwitchesToManifest < ActiveRecord::Migration
  def change
    add_column :manifests, :show_color, :boolean, :null => false, :default => false
    add_column :manifests, :show_count_type, :boolean, :null => false, :default => false
    add_column :manifests, :show_pkg_type, :boolean, :null => false, :default => false
    add_column :manifests, :show_bag_type, :boolean, :null => false, :default => false
    add_column :manifests, :show_plu, :boolean, :null => false, :default => false
  end
end
