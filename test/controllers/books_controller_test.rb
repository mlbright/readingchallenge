require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @challenge = challenges(:one)
    @book = books(:one)
    post login_path, params: { email: @user.email, password: "password" }
  end

  test "should get index" do
    get challenge_books_path(@challenge)
    assert_response :success
  end

  test "should get show" do
    get challenge_book_path(@challenge, @book)
    assert_response :success
  end

  test "should get new" do
    get new_challenge_book_path(@challenge)
    assert_response :success
  end

  test "should get create" do
    post challenge_books_path(@challenge), params: { book: { title: "Test Book", author: "Test Author", pages: 200 } }
    assert_response :redirect
  end

  test "should get edit" do
    get edit_challenge_book_path(@challenge, @book)
    assert_response :success
  end

  test "should get update" do
    patch challenge_book_path(@challenge, @book), params: { book: { title: "Updated Title" } }
    assert_response :redirect
  end

  test "should get destroy" do
    delete challenge_book_path(@challenge, @book)
    assert_response :redirect
  end
end
