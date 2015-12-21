class CountType < ActiveRecord::Base
  acts_as_paranoid                  #Soft-Delete
  belongs_to :product
end
