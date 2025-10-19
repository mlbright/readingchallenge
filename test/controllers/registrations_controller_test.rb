require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get admin_signup" do
    get admin_signup_path
    assert_response :success
  end

  test "should get create_admin" do
    post admin_signup_path, params: { username: "admin", email: "admin@example.com", password: "Password123!", password_confirmation: "Password123!" }
    assert_response :redirect
  end

  test "should get activation" do
    get activation_path
    assert_response :success
  end

  test "should get create" do
    post activation_path
    assert_response :unprocessable_entity
  end
end
