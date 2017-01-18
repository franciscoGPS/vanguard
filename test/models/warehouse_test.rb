# == Schema Information
#
# Table name: warehouses
#
#  id            :integer          not null, primary key
#  name          :string
#  address       :string
#  tax_id        :string
#  greenhouse_id :integer
#  deleted_at    :date
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  phone         :string
#

require 'test_helper'

class WarehouseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
