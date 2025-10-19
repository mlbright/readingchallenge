require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    post login_path, params: { email: @user.email, password: "password" }
  end

  test "should get index" do
    get users_path
    assert_response :success
  end

  test "should get show" do
    get user_path(@user)
    assert_response :success
  end
end
