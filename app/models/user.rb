class User < ActiveRecord::Base

belongs_to :role
has_many :sales
has_many :shipments
has_many :collection_bills
  # Include default devise modules.
  devise :recoverable,
         :rememberable, :trackable, :validatable,
         :lockable

  acts_as_paranoid

  ROLES = %w[superadmin admin user banned sales]


  #before_create :set_default_role
  #private
  #def set_default_role
  #  self.role ||= Role.find_by_name('registered')
  #end
end
