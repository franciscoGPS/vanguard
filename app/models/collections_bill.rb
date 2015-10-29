class CollectionsBill < ActiveRecord::Base
  acts_as_paranoid           #Soft-delete
  belongs_to :user
  belongs_to :sale
end
