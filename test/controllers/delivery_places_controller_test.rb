require 'test_helper'

class DeliveryPlacesControllerTest < ActionController::TestCase
  setup do
    @delivery_place = delivery_places(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:delivery_places)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create delivery_place" do
    assert_difference('DeliveryPlace.count') do
      post :create, delivery_place: {  }
    end

    assert_redirected_to delivery_place_path(assigns(:delivery_place))
  end

  test "should show delivery_place" do
    get :show, id: @delivery_place
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @delivery_place
    assert_response :success
  end

  test "should update delivery_place" do
    patch :update, id: @delivery_place, delivery_place: {  }
    assert_redirected_to delivery_place_path(assigns(:delivery_place))
  end

  test "should destroy delivery_place" do
    assert_difference('DeliveryPlace.count', -1) do
      delete :destroy, id: @delivery_place
    end

    assert_redirected_to delivery_places_path
  end
end
