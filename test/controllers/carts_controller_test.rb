require 'test_helper'

class CartsControllerTest < ActionDispatch::IntegrationTest
  test "should get add_item" do
    get carts_add_item_url
    assert_response :success
  end

  test "should get remove_item" do
    get carts_remove_item_url
    assert_response :success
  end

  test "should get add_discount" do
    get carts_add_discount_url
    assert_response :success
  end

  test "should get remove_discount" do
    get carts_remove_discount_url
    assert_response :success
  end

end
