# == Schema Information
#
# Table name: roles
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted_at :datetime
#

class Role < ActiveRecord::Base
	has_many :users

  acts_as_paranoid   #Soft-delete
end
