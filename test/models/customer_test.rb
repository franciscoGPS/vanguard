# == Schema Information
#
# Table name: customers
#
#  id                :integer          not null, primary key
#  business_name     :string
#  billing_address   :string
#  shipping_address  :string
#  tax_id_number     :string
#  chep_id_number    :string
#  bb_number         :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  deleted_at        :datetime
#  logo_file_name    :string
#  logo_content_type :string
#  logo_file_size    :integer
#  logo_updated_at   :datetime
#  greenhouse_id     :integer
#

require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
