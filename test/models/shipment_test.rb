# == Schema Information
#
# Table name: shipments
#
#  id              :integer          not null, primary key
#  start_at        :date
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  cancel          :boolean          default(FALSE)
#  deleted_at      :datetime
#  product_id      :integer
#  pallets_number  :integer
#  comments        :text
#  sale_id         :integer
#  price           :decimal(, )
#  plu             :boolean
#  customer_id     :integer
#  weight          :float
#  product_color   :string
#  box_type_id     :integer
#  bag_type_id     :integer
#  pallet_type_id  :integer
#  package_type_id :integer
#  po_number       :string
#  quality         :string(30)
#  box_number      :integer
#  count_type_id   :integer
#

require 'test_helper'

class ShipmentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
