class Contact < ActiveRecord::Base
  belongs_to :customer
  acts_as_paranoid                                   # Soft-delete
end
