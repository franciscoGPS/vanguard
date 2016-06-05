class AddColorToGreenhouses < ActiveRecord::Migration
  def change
    add_column :greenhouses, :color, :string
  end
end
