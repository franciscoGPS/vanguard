class Shipment < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :product
  belongs_to :sale

  scope :unconfirmed, -> { where("price is ? OR price = ? OR price < ?", nil, 0, 0 ) }
  scope :confirmed, -> { where("price is ? OR price = ? OR price < ?", nil, 0, 0 ) }


end
