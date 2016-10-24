# == Schema Information
#
# Table name: colors
#
#  id            :integer          not null, primary key
#  name          :string
#  greenhouse_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  deleted_at    :datetime
#

class Color < ActiveRecord::Base
  belongs_to :greenhouse
  acts_as_paranoid                  #Soft-Delete
  validates :greenhouse_id, presence: true
end
