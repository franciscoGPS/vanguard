class ChangeDeliveryPlaceIdFromSales < ActiveRecord::Migration
  def up
    #change_column :sales, :delivery_place_id, :integer
    connection.execute(%q{
      alter table sales
      alter column delivery_place_id
      type integer using cast(delivery_place_id as integer)
    })
  end
  #def down
   # change_column :sales, :delivery_place_id, :string
  #end
end
