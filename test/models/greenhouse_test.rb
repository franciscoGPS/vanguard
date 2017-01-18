# == Schema Information
#
# Table name: greenhouses
#
#  id                 :integer          not null, primary key
#  business_name      :string
#  fiscal_address     :text
#  greenhouse_address :text
#  rfc                :string
#  category           :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  deleted_at         :datetime
#  logo_file_name     :string
#  logo_content_type  :string
#  logo_file_size     :integer
#  logo_updated_at    :datetime
#  fda_num            :string
#  color              :string
#

require 'test_helper'

class GreenhouseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
