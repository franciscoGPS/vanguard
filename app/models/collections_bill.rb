# == Schema Information
#
# Table name: collections_bills
#
#  id               :integer          not null, primary key
#  sale_id          :integer
#  user_id          :integer
#  invoice_number   :integer
#  po_number        :string
#  payment_terms    :string(100)
#  bol_date         :datetime
#  total_amt        :float
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  deleted_at       :datetime
#  customer_id      :integer
#  ship_number      :string
#  proforma_invoice :string
#  show_color       :boolean          default(FALSE), not null
#  show_count_type  :boolean          default(FALSE), not null
#  show_pkg_type    :boolean          default(FALSE), not null
#  show_bag_type    :boolean          default(FALSE), not null
#  show_plu         :boolean          default(FALSE), not null
#  label_one        :string           default(""), not null
#  label_two        :string           default(""), not null
#  bill_of_lading   :string           default(""), not null
#  thermograph      :string           default(""), not null
#  footer_one       :text             default(""), not null
#  footer_two       :text             default(""), not null
#

class CollectionsBill < ActiveRecord::Base
  acts_as_paranoid           #Soft-delete

  belongs_to :user
  belongs_to :sale
  belongs_to :customer, inverse_of: :collections_bill
  has_many :shipments, :through => :customer, :dependent => :destroy, inverse_of: :collections_bill
  has_many :shipment_adjustments, through: :shipments, inverse_of: :collections_bill

  accepts_nested_attributes_for :sale
  accepts_nested_attributes_for :shipment_adjustments

  # Public Activity
  include PublicActivity::Model
  tracked owner:  ->(controller, model) { controller.c_user }

  def adjusted_shipments
    self.sale.shipments.each do |sh|
      if sh.shipment_adjustment.present?
        sh.price = sh.shipment_adjustment.price
        sh.weight = sh.shipment_adjustment.weight
        sh.box_number = sh.shipment_adjustment.box_number
      else
        return nil
      end
    end
  end

  def adjusted?
    self.sale.shipments.each do |sh|
      if sh.shipment_adjustment.present?
        return true
      end
      return false
    end
  end

  def own_shipments
    Shipment.where(:sale_id => self.sale_id, :customer_id => self.customer_id).order(id: :asc)
  end

end
