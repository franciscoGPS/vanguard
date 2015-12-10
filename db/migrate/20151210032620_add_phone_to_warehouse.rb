class AddPhoneToWarehouse < ActiveRecord::Migration
  def change
    add_column :warehouses, :phone, :string
  end
end
