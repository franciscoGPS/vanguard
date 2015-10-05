class Shipment < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :product
  belongs_to :sale

end
