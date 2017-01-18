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

require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
