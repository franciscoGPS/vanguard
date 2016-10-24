# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string
#  job                    :string
#  phone                  :string
#  email                  :string
#  deleted_at             :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  role_id                :integer
#  admin                  :boolean          default(FALSE)
#  superadmin             :boolean          default(FALSE)
#

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

  # def timeout_in
  #  return 4.hours if self.admin?
  #  return 15.minutes if self.superadmin?
  #  1.days
  # end



end
