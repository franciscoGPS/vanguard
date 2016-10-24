# == Schema Information
#
# Table name: count_types
#
#  id         :integer          not null, primary key
#  name       :string
#  product_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted_at :datetime
#

class CountType < ActiveRecord::Base
  acts_as_paranoid                  #Soft-Delete
  belongs_to :product
end
