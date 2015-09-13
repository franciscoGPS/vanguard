require 'test_helper'

class BagTypesControllerTest < ActionController::TestCase
  setup do
    @bag_type = bag_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bag_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bag_type" do
    assert_difference('BagType.count') do
      post :create, bag_type: { name: @bag_type.name }
    end

    assert_redirected_to bag_type_path(assigns(:bag_type))
  end

  test "should show bag_type" do
    get :show, id: @bag_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bag_type
    assert_response :success
  end

  test "should update bag_type" do
    patch :update, id: @bag_type, bag_type: { name: @bag_type.name }
    assert_redirected_to bag_type_path(assigns(:bag_type))
  end

  test "should destroy bag_type" do
    assert_difference('BagType.count', -1) do
      delete :destroy, id: @bag_type
    end

    assert_redirected_to bag_types_path
  end
end
