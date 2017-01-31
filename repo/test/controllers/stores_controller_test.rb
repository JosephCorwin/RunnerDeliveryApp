require 'test_helper'

class StoresControllerTest < ActionDispatch::IntegrationTest

  def setup
    @store1 = stores(:Store_1)
    @store2 = stores(:Store_2)
    @user = users(:michael)
    @boss = users(:boss)
    @flash_fail = "That's my purse I don't know you!"
  end

  test "index should redirect for non-bosses" do
    #anonymous users can't do it 
    get stores_url
    assert_equal flash[:danger], @flash_fail
    assert_redirected_to root_url
    follow_redirect!
    #regular users can't do it
    log_in_as(@user)
    get stores_url
    assert_equal flash[:danger], @flash_fail
    assert_redirected_to root_url
    follow_redirect!
    #bosses can totally do it
    log_in_as(@boss)
    get stores_url
    assert_response :success
    assert_template 'stores/index'
  end

  test "new should should redirect for non-bosses" do
    #anonymous users can't do it 
    get new_stores_path
    assert_redirected_to root_url
    assert_equal flash[:danger], @flash_fail
    follow_redirect!
    #regular users can't do it
    log_in_as(@user)
    get new_stores_path
    assert_equal flash[:danger], @flash_fail
    assert_redirected_to root_url
    follow_redirect!
    #bosses can totally do it
    log_in_as(@boss)
    get new_stores_path
    assert_response :success
    assert_template 'stores/new' 
  end

  test "edit should should redirect for non-bosses" do
    #anonymous users can't do it     
    get edit_store_path(@store1)
    assert_redirected_to root_url
    assert_equal flash[:danger], @flash_fail
    follow_redirect!
    #regular users can't do it
    log_in_as(@user)
    get new_stores_path
    assert_equal flash[:danger], @flash_fail
    assert_redirected_to root_url
    follow_redirect!
    #bosses can totally do it
    log_in_as(@boss)
    get new_stores_path
    assert_response :success
    assert_template 'stores/new'
  end

  test "non-bosses shouldn't be able to delete stores" do
    #anonymous users can't do it 
    assert_no_difference 'Store.count' do
      delete store_path(@store1)
    end
    #regular users can't do it
    log_in_as(@user)
    assert_no_difference 'Store.count' do
      delete store_path(@store1)
    end
    #bosses can totally do it
    log_in_as(@boss)
    assert_difference 'Store.count', -1 do
      delete store_path(@store1)
    end
  end
 

  test "anyone can look at the stores, though" do
    get store_url(@store1)
    assert_response :success
  end


end
