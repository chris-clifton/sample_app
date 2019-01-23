require 'test_helper'
require 'minitest/reporters'
Minitest::Reporters.use!

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:bones)
  end
  
  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "valid login" do
    get login_path
    post login_path, params: { session: { email: @user.email, password: 'password' } }
    assert is_logged_in?                            # check logged in
    assert_redirected_to @user                      # check correct redirect target
    follow_redirect!                                # actually visit target page
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0 # asserts the login link disappears
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end 

  test "login with valid credentials and logout" do
    get login_path
    post login_path, params: { session: {email: @user.email, password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    # Simulate a user clicking logout in a second window.
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_equal cookies['remember_token'] , assigns(:user).remember_token
  end

  test "login without remembering" do
    # Log in to set the cookie
    log_in_as(@user, remember_me: '1')
    # Log in again to verify cookie is deleted
    log_in_as(@user, remember_me: '0')
    assert_empty cookies['remember_token']
  end
end
