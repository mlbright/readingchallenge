class BooksController < ApplicationController
  before_action :require_login
  before_action :set_challenge
  before_action :set_book, only: [ :show, :edit, :update, :destroy ]
  before_action :authorize_user, only: [ :edit, :update, :destroy ]
  before_action :check_participation, only: [ :new, :create ]

  def index
    @books = @challenge.books.includes(:user).order(created_at: :desc)
  end

  def show
    @vote = current_user.votes.find_by(book_id: @book.id)
    @votes = @book.votes.includes(:user)
  end

  def new
    @book = Book.new
  end

  def create
    @book = current_user.books.build(book_params.merge(challenge: @challenge))
    if @book.save
      flash[:notice] = "Book successfully added!"
      redirect_to challenge_book_path(@challenge, @book)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      flash[:notice] = "Book successfully updated!"
      redirect_to challenge_book_path(@challenge, @book)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    flash[:notice] = "Book successfully deleted!"
    redirect_to challenge_books_path(@challenge)
  end

  private

  def set_challenge
    @challenge = Challenge.find(params[:challenge_id])
  end

  def set_book
    @book = @challenge.books.find(params[:id])
  end

  def authorize_user
    unless @book.user == current_user
      flash[:alert] = "You are not authorized to perform this action"
      redirect_to challenge_book_path(@challenge, @book)
    end
  end

  def check_participation
    is_participant = @challenge.participants.include?(current_user) || @challenge.creator == current_user
    unless is_participant
      flash[:alert] = "You must be a participant to add books to this challenge"
      redirect_to @challenge
    end
  end

  def book_params
    params.require(:book).permit(:title, :author, :pages, :description, :url, :completion_date)
  end
end
