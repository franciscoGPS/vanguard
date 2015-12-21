class Contact < ActiveRecord::Base
  belongs_to :customer
  acts_as_paranoid                                   # Soft-delete


  # Public Activity
  include PublicActivity::Model
  tracked owner:  ->(controller, model) { controller.c_user }
end
