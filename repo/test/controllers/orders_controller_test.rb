require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @cust = users(:michael)
    @boss = users(:boss)
    @run1 = users(:flash)
    @run2 = users(:dash)
    @ord1 = orders(:one)
    @ord2 = orders(:two)
  end


  test "should get new" do
    log_in_as(@cust)
    get new_orders_path
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@boss)
    get edit_order_url(@ord1)
    assert_response :success
  end

  test "should get show" do
    log_in_as(@cust)
    get order_url(@ord1)
    assert_response :success
  end

end
