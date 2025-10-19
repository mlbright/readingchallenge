require "test_helper"

class VotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @challenge = challenges(:two)  # Use challenge two
    @book = books(:two)  # book two belongs to challenge two and user two
    post login_path, params: { email: @user.email, password: "password" }
  end

  test "should get create" do
    post challenge_book_votes_path(@challenge, @book), params: { vote: { veto_reason: "This book does not fit the challenge criteria" } }
    assert_response :redirect
  end

  test "should get destroy" do
    # Use existing vote from fixtures (user one voting on book two)
    vote = votes(:one)
    delete challenge_book_vote_path(@challenge, @book, vote)
    assert_response :redirect
  end
end
