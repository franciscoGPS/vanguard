class Shipment < ActiveRecord::Base
  acts_as_paranoid
#Se entiende como Shipemnt esa combinación de
#Producto + cliente + orden de venta (Sale)
#y otras configuraciones.

#Estos 4 son parámetros del Shipment
#La tabla Shipments en la DB contiene los siguientes id's
  has_one :package_type
  has_one :bag_type
  has_one :pallet_type
  has_one :box_type
  belongs_to :product
  belongs_to :sale
  belongs_to :customer

  scope :unconfirmed, -> { where("price is ? OR price = ? OR price < ?", nil, 0, 0 ) }
  scope :confirmed, -> { where("price is ? OR price = ? OR price < ?", nil, 0, 0 ) }
  scope :to_edit, -> (sale_id) { where(:sale_id => sale_id) }

    def find_by_sale_id(sale_id)
          find(:conditions => [ "sale_id = ?", sale_id]).as_json
    end




end

