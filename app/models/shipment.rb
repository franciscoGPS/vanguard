class Shipment < ActiveRecord::Base
  acts_as_paranoid

  has_many :products
  accepts_nested_attributes_for :products
end
