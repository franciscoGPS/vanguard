class ShipmentAdjustment < ActiveRecord::Base
  belongs_to :shipment
  validates :shipment, presence: true
end
