# == Schema Information
#
# Table name: contacts
#
#  id               :integer          not null, primary key
#  name             :string
#  email            :string
#  phone_office     :string
#  phone            :string
#  contactable_id   :integer
#  contactable_type :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  deleted_at       :datetime
#

class Contact < ActiveRecord::Base
  belongs_to :customer
  acts_as_paranoid                                   # Soft-delete


  # Public Activity
  include PublicActivity::Model
  tracked owner:  ->(controller, model) { controller.c_user }
end
