require 'test_helper'

class ProcessOrderTest < ActionDispatch::IntegrationTest

  def setup
    @boss = users(:boss)
    @cust = users(:michael)
    @arch = users(:archer)
    @run1 = users(:flash)
    @run2 = users(:dash)
  end

  test "order creation process" do
    log_in_as(@cust)
    get new_order_url
    assert_select 'form[action="/orders"]'
    assert_difference 'Order.count', 1 do
      byebug
      post orders_url, params: { order: {what_they_want: 'A bunch of stuff', where_it_goes: 'my house' } }
    end
    @order = assigns[:order]
    assert_redirected_to order_url
    follow_redirect!
    assert_template 'orders/show'
    log_in_as(@boss)
    get order_url(@order)
    assert_match what_they_want
    get edit_order_url(@order)
    assert_equal @order.runner_id, 1
    assert_template 'orders/edit'
    patch orders_url, params: { order: {id: @order.id, runner_id: @run1.id, where_to_get: 'my house'} }
    assert_equal @order.runner_id, @run1.id
    assert_not_empty @order.where_to_get
    log_in_as(@run1)
    get order_url(@order)
    assert_match where_to_get
  end
end
