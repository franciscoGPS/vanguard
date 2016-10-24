# == Schema Information
#
# Table name: box_types
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted_at :datetime
#

class BoxType < ActiveRecord::Base

  acts_as_paranoid
end
