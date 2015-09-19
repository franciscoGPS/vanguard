class Product < ActiveRecord::Base
  belongs_to :greenhouse

  has_one :package_type
  has_one :bag_type
  has_one :pallet_type
  has_one :box_type

  has_many :shipments

  acts_as_paranoid                        # Soft-delete

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
