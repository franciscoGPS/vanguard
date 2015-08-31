class Product < ActiveRecord::Base

##Propiedades del producto. Disponibles en la base de datos, y extraidos de la migración "XXX..._create_products.rb"
	   #t.string :name
      #t.references :greenhouse
      #t.references :package_type
      #t.references :box_type
      #t.string :weights_avail
      #t.references :pallet_type
      #t.references :bag_type
      #t.boolean :active
end
