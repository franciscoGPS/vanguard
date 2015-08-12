class User < ActiveRecord::
	belongs_to :role
  # Include default devise modules.
  devise :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable,
         :lockable
  acts_as_paranoid
end
