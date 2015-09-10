require 'test_helper'

class PalletTypesControllerTest < ActionController::TestCase
  setup do
    @pallet_type = pallet_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pallet_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pallet_type" do
    assert_difference('PalletType.count') do
      post :create, pallet_type: { name: @pallet_type.name }
    end

    assert_redirected_to pallet_type_path(assigns(:pallet_type))
  end

  test "should show pallet_type" do
    get :show, id: @pallet_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pallet_type
    assert_response :success
  end

  test "should update pallet_type" do
    patch :update, id: @pallet_type, pallet_type: { name: @pallet_type.name }
    assert_redirected_to pallet_type_path(assigns(:pallet_type))
  end

  test "should destroy pallet_type" do
    assert_difference('PalletType.count', -1) do
      delete :destroy, id: @pallet_type
    end

    assert_redirected_to pallet_types_path
  end
end
