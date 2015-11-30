class Customer < ActiveRecord::Base
  include Paperclip::Glue
  acts_as_paranoid
  belongs_to :greenhouse, dependent: :destroy
  has_many :contacts, :as => :contactable, :class_name => "Contact", dependent: :destroy
  has_many :shipments, dependent: :destroy, :source_type => "Shipment"
  has_many :shipment_state_changes
  has_many :sales, :through => :shipments, :dependent => :destroy
  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "no-logo.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/


  accepts_nested_attributes_for :contacts,  :allow_destroy => true
  accepts_nested_attributes_for :shipments, :allow_destroy => true

  scope :own_customers, -> (greenhouse_id) { where(:greenhouse_id => greenhouse_id) }


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

  def shipments_by_sale(sale_id)
    Shipment.where(:sale_id => sale_id, :customer_id => self.id)
  end
end

