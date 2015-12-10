class Role < ActiveRecord::Base
	has_many :users

  acts_as_paranoid   #Soft-delete


  # Public Activity
  include PublicActivity::Model
  tracked owner:  ->(controller, model) { controller.c_user }
end
