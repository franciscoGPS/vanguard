class Manifest < ActiveRecord::Base
  acts_as_paranoid                                   # Soft-delete
  belongs_to :sale
end
