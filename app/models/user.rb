class User < ActiveRecord::Base

belongs_to :role
has_many :sales
has_many :shipments
has_many :collection_bills
  # Include default devise modules.
  devise :recoverable, :database_authenticatable,
         :rememberable, :trackable, :validatable,
         :lockable

  acts_as_paranoid

  ROLES = %w[superadmin admin user banned sales]


end
