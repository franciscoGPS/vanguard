class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :phone_office
      t.string :phone
      t.references :contactable, polymorphic: true, index: true
      t.timestamps null: false
    end
  end
end
