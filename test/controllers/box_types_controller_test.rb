require 'test_helper'

class BoxTypesControllerTest < ActionController::TestCase
  setup do
    @box_type = box_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:box_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create box_type" do
    assert_difference('BoxType.count') do
      post :create, box_type: { name: @box_type.name }
    end

    assert_redirected_to box_type_path(assigns(:box_type))
  end

  test "should show box_type" do
    get :show, id: @box_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @box_type
    assert_response :success
  end

  test "should update box_type" do
    patch :update, id: @box_type, box_type: { name: @box_type.name }
    assert_redirected_to box_type_path(assigns(:box_type))
  end

  test "should destroy box_type" do
    assert_difference('BoxType.count', -1) do
      delete :destroy, id: @box_type
    end

    assert_redirected_to box_types_path
  end
end
