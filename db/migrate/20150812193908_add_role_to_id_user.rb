class AddRoleToIdUser < ActiveRecord::Migration
  def change
    add_reference :id_users, :role, index: true, foreign_key: true
  end
end
