  class DeliveryPlace < ActiveRecord::Base
    acts_as_paranoid                  #Soft-Delete
    has_many :sales
  end
