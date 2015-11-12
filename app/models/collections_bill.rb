class CollectionsBill < ActiveRecord::Base
  acts_as_paranoid           #Soft-delete
  belongs_to :user
  belongs_to :sale
  has_many :shipments, :through => :shipments, :dependent => :destroy
end
