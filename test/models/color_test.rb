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

require 'test_helper'

class ColorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
