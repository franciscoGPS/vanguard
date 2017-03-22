# == Schema Information
#
# Table name: shipments
#
#  id              :integer          not null, primary key
#  start_at        :date
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  cancel          :boolean          default(FALSE)
#  deleted_at      :datetime
#  product_id      :integer
#  pallets_number  :integer
#  comments        :text
#  sale_id         :integer
#  price           :decimal(, )
#  plu             :boolean
#  customer_id     :integer
#  weight          :float
#  product_color   :string
#  box_type_id     :integer
#  bag_type_id     :integer
#  pallet_type_id  :integer
#  package_type_id :integer
#  po_number       :string
#  quality         :string(30)
#  box_number      :integer
#  count_type_id   :integer
#

class Shipment < ActiveRecord::Base
  acts_as_paranoid
  include ActionView::Helpers::NumberHelper
#Se entiende como Shipemnt esa combinación de
#Producto + cliente + orden de venta (Sale)
#y otras configuraciones.

#Estos 4 son parámetros del Shipment
#La tabla Shipments en la DB contiene los siguientes id's


  belongs_to :product
  belongs_to :sale
  belongs_to :customer
  belongs_to :collection_bills
  has_one :greenhouse, through: :sale
  has_one :count_type
  has_one :shipment_adjustment, dependent: :destroy, inverse_of: :shipment

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

  def own_color(greenhouse_id)
    color = Color.where("greenhouse_id = ? AND id = ?", greenhouse_id, self.product_color).first
      return color != nil ? color.name : ""
  end


  def plu_to_string
    self.plu ? "PLU STICKERED" : "NO PLU STICKERED"
  end

  def pallet_type
    if(self.pallet_type_id != nil)
      PalletType.find(self.pallet_type_id)
    else
      PalletType.new
    end
  end

  def package_type
    if(self.package_type_id != nil)
      PackageType.find(self.package_type_id)
    else
      PackageType.new
    end
  end

  def box_type
    if(self.box_type_id != nil)
    BoxType.find(self.box_type_id)
  else
    BoxType.new
  end
  end

  def bag_type
    if(self.bag_type_id != nil)
    BagType.find(self.bag_type_id)
  else
    BagType.new
  end
  end

  def count_type
    if(self.count_type_id != nil)
      CountType.find(self.count_type_id)
    else
      CountType.new
    end
  end

  # def product_color_one
  #   if self.product_color = nil
  #     if self.sale.product_color = nil
  #       "Not defined"
  #     else
  #       self.sale.product_color
  #     end
  #   else
  #     product_color
  #   end
  # end

  def formatted_boxes
    number_with_delimiter(self.box_number)
  end

  def formatted_weight
    number_with_precision(self.weight, precision: 0)
  end




end

