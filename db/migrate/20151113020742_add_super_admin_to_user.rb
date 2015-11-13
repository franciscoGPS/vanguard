class AddSuperAdminToUser < ActiveRecord::Migration
  def change
    add_column :users, :superadmin, :boolean, :default => false
  end
end
