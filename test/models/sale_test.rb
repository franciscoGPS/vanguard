# == Schema Information
#
# Table name: sales
#
#  id                   :integer          not null, primary key
#  season               :string
#  departure_date       :date
#  arrival_date         :date
#  annotation           :text
#  comment              :text
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  deleted_at           :datetime
#  user_id              :integer
#  aasm_state           :string
#  revision             :boolean          default(FALSE)
#  greenhouse_id        :integer
#  purshase_order       :boolean          default(FALSE)
#  out_of_packaging     :boolean          default(FALSE)
#  docs_reception       :boolean          default(FALSE)
#  loading_docs         :boolean          default(FALSE)
#  arrived_to_border    :boolean          default(FALSE)
#  out_of_courtyard     :boolean          default(FALSE)
#  documents            :boolean          default(FALSE)
#  mex_customs_mod      :boolean          default(FALSE)
#  us_customs_mod       :boolean          default(FALSE)
#  usda                 :boolean          default(FALSE)
#  ramp                 :boolean          default(FALSE)
#  fda                  :boolean          default(FALSE)
#  hold                 :boolean          default(FALSE)
#  arrived_to_warehouse :boolean          default(FALSE)
#  picked_up_by_cust    :boolean          default(FALSE)
#  bol                  :boolean          default(FALSE)
#  hld_qty              :integer          default(0)
#  product_color        :string
#  ship_number          :string
#  delivery_place_id    :integer
#  warehouse_id         :integer
#

require 'test_helper'

class SaleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
