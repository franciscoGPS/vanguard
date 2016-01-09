require 'test_helper'

class CollectionsBillsControllerTest < ActionController::TestCase
  setup do
    @collections_bill = collections_bills(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:collections_bills)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create collections_bill" do
    assert_difference('CollectionsBill.count') do
      post :create, collections_bill: { bol_date: @collections_bill.bol_date, invoice_number: @collections_bill.invoice_number, payment_terms: @collections_bill.payment_terms, po_number: @collections_bill.po_number, sale_id: @collections_bill.sale_id, ship_number: @collections_bill.ship_number, total_amt: @collections_bill.total_amt }
    end

    assert_redirected_to collections_bill_path(assigns(:collections_bill))
  end

  test "should show collections_bill" do
    get :show, id: @collections_bill
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @collections_bill
    assert_response :success
  end

  test "should update collections_bill" do
    patch :update, id: @collections_bill, collections_bill: { bol_date: @collections_bill.bol_date, invoice_number: @collections_bill.invoice_number, payment_terms: @collections_bill.payment_terms, po_number: @collections_bill.po_number, sale_id: @collections_bill.sale_id, ship_number: @collections_bill.ship_number, total_amt: @collections_bill.total_amt }
    assert_redirected_to collections_bill_path(assigns(:collections_bill))
  end

  test "should destroy collections_bill" do
    assert_difference('CollectionsBill.count', -1) do
      delete :destroy, id: @collections_bill
    end

    assert_redirected_to collections_bills_path
  end
end
