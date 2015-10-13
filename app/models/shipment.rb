class Shipment < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :product
  belongs_to :sale

  scope :unconfirmed, -> { where("price is ? OR price = ? OR price < ?", nil, 0, 0 ) }
  scope :confirmed, -> { where("price is ? OR price = ? OR price < ?", nil, 0, 0 ) }
  scope :to_edit, -> (sale_id) { where(:sale_id => sale_id) }

def find_by_sale_id(sale_id)
      find(:conditions => [ "sale_id = ?", sale_id]).as_json
    end
end
