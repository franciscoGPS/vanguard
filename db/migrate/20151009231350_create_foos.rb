class CreateFoos < ActiveRecord::Migration
  def change
    create_table :foos do |t|

      t.timestamps null: false
    end
  end
end
