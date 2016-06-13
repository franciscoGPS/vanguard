require 'test_helper'

class CustomBrokersControllerTest < ActionController::TestCase
  setup do
    @custom_broker = custom_brokers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:custom_brokers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create custom_broker" do
    assert_difference('CustomBroker.count') do
      post :create, custom_broker: {  }
    end

    assert_redirected_to custom_broker_path(assigns(:custom_broker))
  end

  test "should show custom_broker" do
    get :show, id: @custom_broker
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @custom_broker
    assert_response :success
  end

  test "should update custom_broker" do
    patch :update, id: @custom_broker, custom_broker: {  }
    assert_redirected_to custom_broker_path(assigns(:custom_broker))
  end

  test "should destroy custom_broker" do
    assert_difference('CustomBroker.count', -1) do
      delete :destroy, id: @custom_broker
    end

    assert_redirected_to custom_brokers_path
  end
end
