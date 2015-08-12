class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable,
         :lockable
  acts_as_paranoid
end
