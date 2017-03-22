# == Schema Information
#
# Table name: customers
#
#  id                :integer          not null, primary key
#  business_name     :string
#  billing_address   :string
#  shipping_address  :string
#  tax_id_number     :string
#  chep_id_number    :string
#  bb_number         :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  deleted_at        :datetime
#  logo_file_name    :string
#  logo_content_type :string
#  logo_file_size    :integer
#  logo_updated_at   :datetime
#  greenhouse_id     :integer
#

class Customer < ActiveRecord::Base
  include Paperclip::Glue
  acts_as_paranoid
  belongs_to :greenhouse
  has_many :contacts, :as => :contactable, :class_name => "Contact", dependent: :destroy
  has_many :shipments, dependent: :destroy, :source_type => "Shipment", inverse_of: :customer
  has_many :shipment_state_changes
  has_many :collections_bills, inverse_of: :customer
  has_many :sales, :through => :shipments, :dependent => :destroy
  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "no-logo.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/


  accepts_nested_attributes_for :contacts, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :shipments, :allow_destroy => true

  scope :own_customers, -> (greenhouse_id) { where(:greenhouse_id => greenhouse_id) }

  def self.options_for_select(greenhouse_id)
    where(:greenhouse_id => greenhouse_id).order('LOWER(business_name)').map { |e| [e.business_name, e.id] }
  end

  # Public Activity
  include PublicActivity::Model
  tracked owner:  ->(controller, model) { controller.c_user }

  def customers_in_sale(sale)
    many_customers = ""

    i = 1;
    Customer.where(id: sale.customers).select(:business_name).distinct.select(:id).each_with_index do |customer|
      if i == 1
        many_customers = customer.business_name.to_s
        i = i+1
      else
        many_customers = many_customers +', ' + customer.business_name.to_s
      end
    end
    return many_customers
  end

  #Este query del método de abajo extrae los id's de los clientes de una venta.
  #def method_name
    #select customers.id from customers -- customers has_many shipmentes... shipments belongs_to customers and sales.... sales has_many shipments
    #inner join shipments ON shipments.customer_id IN (customers.id) AND shipments.sale_id = 88 group by customers.id
  #end

end

