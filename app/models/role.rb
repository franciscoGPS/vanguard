class Role < ActiveRecord::Base
	has_many :users, :sales, :admins
end
