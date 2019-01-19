require 'test_helper'
require 'minitest/reporters'
Minitest::Reporters.use!

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get login_path
    assert_response :success
  end

end
