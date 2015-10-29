require 'test_helper'

class ManifestsControllerTest < ActionController::TestCase
  setup do
    @manifest = manifests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:manifests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create manifest" do
    assert_difference('Manifest.count') do
      post :create, manifest: { alpha: @manifest.alpha, caat: @manifest.caat, carrier: @manifest.carrier, comments: @manifest.comments, custom_broker: @manifest.custom_broker, date: @manifest.date, delivery_person: @manifest.delivery_person, driver: @manifest.driver, fda_num: @manifest.fda_num, pallet_number: @manifest.pallet_number, person_receiving: @manifest.person_receiving, purshase_order: @manifest.purshase_order, sale_id: @manifest.sale_id, sent_to: @manifest.sent_to, shipment: @manifest.shipment, sold_to: @manifest.sold_to, stamp: @manifest.stamp, thermograph: @manifest.thermograph, trailer_num: @manifest.trailer_num, trailer_num_lp: @manifest.trailer_num_lp, trailer_size: @manifest.trailer_size, truck: @manifest.truck, truck_licence_plate: @manifest.truck_licence_plate }
    end

    assert_redirected_to manifest_path(assigns(:manifest))
  end

  test "should show manifest" do
    get :show, id: @manifest
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @manifest
    assert_response :success
  end

  test "should update manifest" do
    patch :update, id: @manifest, manifest: { alpha: @manifest.alpha, caat: @manifest.caat, carrier: @manifest.carrier, comments: @manifest.comments, custom_broker: @manifest.custom_broker, date: @manifest.date, delivery_person: @manifest.delivery_person, driver: @manifest.driver, fda_num: @manifest.fda_num, pallet_number: @manifest.pallet_number, person_receiving: @manifest.person_receiving, purshase_order: @manifest.purshase_order, sale_id: @manifest.sale_id, sent_to: @manifest.sent_to, shipment: @manifest.shipment, sold_to: @manifest.sold_to, stamp: @manifest.stamp, thermograph: @manifest.thermograph, trailer_num: @manifest.trailer_num, trailer_num_lp: @manifest.trailer_num_lp, trailer_size: @manifest.trailer_size, truck: @manifest.truck, truck_licence_plate: @manifest.truck_licence_plate }
    assert_redirected_to manifest_path(assigns(:manifest))
  end

  test "should destroy manifest" do
    assert_difference('Manifest.count', -1) do
      delete :destroy, id: @manifest
    end

    assert_redirected_to manifests_path
  end
end
