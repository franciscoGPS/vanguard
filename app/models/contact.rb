class Contact < ActiveRecord::Base
  acts_as_paranoid                                   # Soft-delete
end
