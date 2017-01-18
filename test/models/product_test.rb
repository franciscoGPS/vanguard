# == Schema Information
#
# Table name: products
#
#  id            :integer          not null, primary key
#  name          :string
#  greenhouse_id :integer
#  active        :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  deleted_at    :datetime
#  brand         :string
#  description   :string
#

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
