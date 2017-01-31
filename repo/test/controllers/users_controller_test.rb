require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
 

  def setup
    @user       = users(:michael)
    @other_user = users(:archer)
    @boss       = users(:boss)
  end

  test "should get signup" do
    get signup_url
    assert_response :success
  end

  test "users should be able to see themself" do
    log_in_as(@user)
    get user_path(@user)
    assert_response :success
  end

  test "users should not be able to see each other" do
    log_in_as(@user)
    get user_path(@other_user)
    assert_redirected_to root_url
  end

  test "bosses should be able to see anyone" do
    log_in_as(@boss)
    get user_path(@user)
    assert_response :success
    get user_path(@other_user)
    assert_response :success
  end

  test "should redirect edit to login if not logged in" do
    get edit_user_path(@user)
    assert_redirected_to login_url
  end

  test "should redirect update to login if not logged in" do
    patch user_path(@user), params: @edit_params
    assert_redirected_to login_url
  end

  test "users should not be able to edit each other" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "users really should not be able to edit each other" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { first_name: @user.first_name,
                                              last_name:  @user.last_name,  
                                              email:      @user.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "users really should not be able to delete each other" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
  end

  test "admins can delete whoever they like" do
    log_in_as(@boss)
    assert_difference 'User.count', -1 do
      delete user_path(@user)
    end
  end

  test "should not allow the status attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not you_da_boss?(@other_user)
    patch user_path(@other_user), params: {
                                    user: { password:              'password',
                                            password_confirmation: 'password',
                                            status: 'boss' } }
    assert_not_equal @other_user.status, 'boss'
  end

end
