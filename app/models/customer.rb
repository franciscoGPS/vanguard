class Customer < ActiveRecord::Base
  acts_as_paranoid
  has_many :contacts, :as => :contactable, :class_name => "Contact", dependent: :destroy
  has_many :shipments, dependent: :destroy, :source_type => "Shipment"
  has_many :shipment_state_changes


  accepts_nested_attributes_for :contacts,  :allow_destroy => true
  accepts_nested_attributes_for :shipments, :allow_destroy => true

  def customers_in_sale(sale)
    @many_customers = ""

    i = 1;
    Customer.where(id: sale.customers).select(:business_name).distinct.select(:id).each_with_index do |customer|
      if i == 1
        @many_customers = customer.business_name
        i = i+1
      else
        @many_customers = @many_customers +', ' + customer.business_name.to_s
      end
    end
    return @many_customers
  end

end

