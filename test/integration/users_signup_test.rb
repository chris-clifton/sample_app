require 'test_helper'
require 'minitest/reporters'
Minitest::Reporters.use!

class UsersSignupTest < ActionDispatch::IntegrationTest
 
  test "invalid signup info" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "",
                                 email: "user@invalid",
                                 password: "foobarbaz",
                                 password_confirmation: "foobarbaz"}}
    end
    assert_template 'users/new'
    # assert_select 'div#<CSS id for error explanation>'
    # assert_select 'div.<CSS class for field with error>'
  end

  test "valid signup" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: "Example User",
                                         email: "user@example.com",
                                         password:              "foobarbaz",
                                         password_confirmation: "foobarbaz" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.nil?
  end

end