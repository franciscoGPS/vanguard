class Shipment < ActiveRecord::Base
  acts_as_paranoid

  has_many :greenhouses
  accepts_nested_attributes_for :greenhouses
end
