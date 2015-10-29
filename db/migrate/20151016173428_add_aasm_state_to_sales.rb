class AddAasmStateToSales < ActiveRecord::Migration
  def change
    add_column :sales, :aasm_state, :string
  end
end
