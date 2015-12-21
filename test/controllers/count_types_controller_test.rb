require 'test_helper'

class CountTypesControllerTest < ActionController::TestCase
  setup do
    @count_type = count_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:count_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create count_type" do
    assert_difference('CountType.count') do
      post :create, count_type: { name: @count_type.name, product_id: @count_type.product_id }
    end

    assert_redirected_to count_type_path(assigns(:count_type))
  end

  test "should show count_type" do
    get :show, id: @count_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @count_type
    assert_response :success
  end

  test "should update count_type" do
    patch :update, id: @count_type, count_type: { name: @count_type.name, product_id: @count_type.product_id }
    assert_redirected_to count_type_path(assigns(:count_type))
  end

  test "should destroy count_type" do
    assert_difference('CountType.count', -1) do
      delete :destroy, id: @count_type
    end

    assert_redirected_to count_types_path
  end
end
