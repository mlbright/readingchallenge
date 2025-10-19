require "test_helper"

class ChallengesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @challenge = challenges(:one)
    post login_path, params: { email: @user.email, password: "password" }
  end

  test "should get index" do
    get challenges_path
    assert_response :success
  end

  test "should get show" do
    get challenge_path(@challenge)
    assert_response :success
  end

  test "should get new" do
    get new_challenge_path
    assert_response :success
  end

  test "should get create" do
    post challenges_path, params: { challenge: { name: "Test Challenge", description: "Test", due_date: 1.year.from_now } }
    assert_response :redirect
  end

  test "should get edit" do
    get edit_challenge_path(@challenge)
    assert_response :success
  end

  test "should get update" do
    patch challenge_path(@challenge), params: { challenge: { name: "Updated Name" } }
    assert_response :redirect
  end

  test "should get destroy" do
    delete challenge_path(@challenge)
    assert_response :redirect
  end
end
