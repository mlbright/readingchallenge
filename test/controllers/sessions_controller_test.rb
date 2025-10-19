require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get login_path
    assert_response :success
  end

  test "should get create" do
    user = users(:one)
    post login_path, params: { email: user.email, password: "password" }
    assert_response :redirect
  end

  test "should get destroy" do
    delete logout_path
    assert_response :redirect
  end
end
