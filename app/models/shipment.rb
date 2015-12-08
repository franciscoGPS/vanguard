class Shipment < ActiveRecord::Base
  acts_as_paranoid
#Se entiende como Shipemnt esa combinación de
#Producto + cliente + orden de venta (Sale)
#y otras configuraciones.

#Estos 4 son parámetros del Shipment
#La tabla Shipments en la DB contiene los siguientes id's

  has_one :count_type
  belongs_to :product
  belongs_to :sale
  belongs_to :customer

  accepts_nested_attributes_for :product, :reject_if => :all_blank

  scope :unconfirmed, -> { where("price is ? OR price = ? OR price < ?", nil, 0, 0 ) }
  scope :confirmed, -> { where("price is ? OR price = ? OR price < ?" , nil, 0, 0 ) }
  scope :to_edit, -> (sale_id) { where(("sale_id = ?"), sale_id) }


  scope :different_products_in_sale, -> (sale_id) { where(sale_id: sale_id ).joins(:product).select("products.id","products.name").uniq }
   #def different_products_in_sale(sale_id)
    #  Shipment.where(sale_id: @sale ).joins(:product).select("products.id","products.name").uniq
    #end

  #scope :distinct_products_in_sale, -> (sale_id) { where (sale_id: => sale_id).join(:products).group(:name) }

    def find_by_sale_id(sale_id)
          find(:conditions => [ "sale_id = ?", sale_id]).as_json
    end



  def plu_to_string
    self.plu ? "PLU STICKERED" : "NO PLU STICKERED"
  end

  def pallet_type
    PalletType.find(self.pallet_type_id)
  end

  def package_type
    PackageType.find(self.package_type_id)
  end

  def box_type
    BoxType.find(self.box_type_id)
  end

  def bag_type
    BagType.find(self.bag_type_id)
  end

  def count_type
    CountType.find(self.count_type_id)
  end

  def product_color_one
    if self.product_color = nil
      if self.sale.product_color = nil
        "Not defined"
      else
        self.sale.product_color
      end
    else
      product_color
    end
  end




end

