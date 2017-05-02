class ShipmentAdjustment < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  belongs_to :shipment
  has_one :collections_bill, through: :shipment
  validates :shipment, presence: true



  def formatted_weight
    number_with_precision(self.weight, precision: 0)
  end

  def formatted_boxes
    number_with_delimiter(self.box_number)
  end

end
