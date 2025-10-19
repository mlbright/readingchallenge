require "test_helper"

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    # Create an admin user so we don't get redirected to admin_signup
    User.create!(username: "admin", email: "admin@example.com", password: "Password123!", admin: true)

    get welcome_index_url
    assert_response :redirect  # Should redirect to login since not logged in
    assert_redirected_to login_path
  end
end
