class Sale < ActiveRecord::Base
  has_many :shipments
  accepts_nested_attributes_for :shipments, :reject_if => :all_blank
  acts_as_paranoid
end
