require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  
  test "home page works good" do
    get root_path
    assert_template 'static/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", faq_path
    assert_select "a[href=?]", signup_path
   end
end
