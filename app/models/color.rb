class Color < ActiveRecord::Base
  belongs_to :greenhouse
  acts_as_paranoid                  #Soft-Delete
end
