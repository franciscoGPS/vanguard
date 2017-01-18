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

require 'test_helper'

class CountTypeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
