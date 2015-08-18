class User < ActiveRecord::Base

  # Include default devise modules.
  devise :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable,
         :lockable

  acts_as_paranoid

  belongs_to :role
  #before_create :set_default_role
  #private
  #def set_default_role
  #  self.role ||= Role.find_by_name('registered')
  #end
end
