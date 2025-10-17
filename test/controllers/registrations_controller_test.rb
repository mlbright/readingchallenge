require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get admin_signup" do
    get registrations_admin_signup_url
    assert_response :success
  end

  test "should get create_admin" do
    get registrations_create_admin_url
    assert_response :success
  end

  test "should get signup" do
    get registrations_signup_url
    assert_response :success
  end

  test "should get create" do
    get registrations_create_url
    assert_response :success
  end
end
