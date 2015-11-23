class AddFdaNumberToGreenhouse < ActiveRecord::Migration
  def change
    add_column :greenhouses, :fda_num, :string
  end
end
