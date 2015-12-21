class Role < ActiveRecord::Base
	has_many :users

  acts_as_paranoid   #Soft-delete
end
