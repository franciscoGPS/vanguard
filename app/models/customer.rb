class Customer < ActiveRecord::Base
  has_many :contacts, :as => :contactable, :class_name => "Contact", dependent: :destroy
  has_many :shipments, dependent: :destroy, :source_type => "Shipment"


  accepts_nested_attributes_for :contacts,  :allow_destroy => true
  accepts_nested_attributes_for :shipments, :allow_destroy => true




  acts_as_paranoid
end

