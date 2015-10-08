class Sale < ActiveRecord::Base
  has_many :shipments
  belongs_to :user
  accepts_nested_attributes_for :shipments, :reject_if => :all_blank
  acts_as_paranoid
end
