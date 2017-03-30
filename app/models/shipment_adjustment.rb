class ShipmentAdjustment < ActiveRecord::Base
  belongs_to :shipment
  has_one :collections_bill, through: :shipment
  validates :shipment, presence: true
end
