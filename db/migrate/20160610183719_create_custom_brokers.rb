class CreateCustomBrokers < ActiveRecord::Migration
  def change
    create_table :custom_brokers do |t|
      t.string :name
      t.string :address
      t.string :country_code
      t.timestamp :deleted_at

      t.timestamps null: false
    end
  end
end
