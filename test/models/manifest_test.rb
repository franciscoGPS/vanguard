# == Schema Information
#
# Table name: manifests
#
#  id                  :integer          not null, primary key
#  sale_id             :integer
#  date                :date
#  carrier             :string
#  driver              :string
#  truck               :string
#  truck_licence_plate :string
#  trailer_num         :string
#  trailer_num_lp      :string
#  stamp               :string
#  thermograph         :string
#  po_number           :string
#  delivery_person     :string
#  person_receiving    :string
#  trailer_size        :integer
#  caat                :string
#  alpha               :string
#  fda_num             :string
#  comments            :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  deleted_at          :date
#  sold_to             :string
#  sold_to_id          :integer
#  total_pallets       :integer          default(0)
#  manifest_number     :integer          default(0)
#  mex_custom_broker   :string
#  usa_custom_broker   :string
#  warehouse_id        :integer
#  ship_number         :string
#  custom_invoice_id   :integer
#  leyend              :text
#  show_color          :boolean          default(FALSE), not null
#  show_count_type     :boolean          default(FALSE), not null
#  show_pkg_type       :boolean          default(FALSE), not null
#  show_bag_type       :boolean          default(FALSE), not null
#  show_plu            :boolean          default(FALSE), not null
#

require 'test_helper'

class ManifestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
