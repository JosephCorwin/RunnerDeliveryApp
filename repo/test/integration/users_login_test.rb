require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "Invalid Login" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    #make sure the flash doesn't follow you
    get root_path
    assert flash.empty?
  end

test "login/logout cycle --full" do
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert_redirected_to @user
    follow_redirect!
    assert logged_in?
    assert_template 'users/show'
    assert_select "a[href=?]", login_path,       count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", profile_path
    #we done here
    delete logout_path
    assert_redirected_to root_url
    follow_redirect!
    assert_not logged_in?
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", profile_path,     count: 0
    #what if they double browsin' tho?
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_equal cookies['remember_token'], assigns(:user).remember_token 
  end

  test "login without remembering" do
    # Log in to set the cookie.
    log_in_as(@user, remember_me: '1')
    delete logout_path
    # Log in again and assert the cookie is deleted.
    log_in_as(@user, remember_me: '0')
    assert_equal cookies['remember_token'], '' #remember_token is an empty string #shouldbenil
  end

end
