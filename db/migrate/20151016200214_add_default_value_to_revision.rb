class AddDefaultValueToRevision < ActiveRecord::Migration
  def up
    change_column :sales, :revision, :boolean, :default => false
  end
end
