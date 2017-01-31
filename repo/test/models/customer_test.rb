require 'test_helper'

class CustomerTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
  end

  test "sanity" do
    #user method to create customer account works
    @account1 = @user.account
    assert @account1
    assert_no_difference 'Customer.count' do
      @account2 = @user.add_customer_account
    end
    assert_equal @account1, @user.account
    assert_not @account2
  end
  
end
