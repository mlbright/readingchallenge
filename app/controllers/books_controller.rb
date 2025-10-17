class BooksController < ApplicationController
  before_action :require_login
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]
  
  def index
    @books = Book.includes(:user).order(created_at: :desc)
  end

  def show
    @vote = current_user.votes.find_by(book_id: @book.id)
    @votes = @book.votes.includes(:user)
  end

  def new
    @book = Book.new
  end

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      flash[:notice] = "Book successfully added!"
      redirect_to @book
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      flash[:notice] = "Book successfully updated!"
      redirect_to @book
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    flash[:notice] = "Book successfully deleted!"
    redirect_to books_path
  end
  
  private
  
  def set_book
    @book = Book.find(params[:id])
  end
  
  def authorize_user
    unless @book.user == current_user
      flash[:alert] = "You are not authorized to perform this action"
      redirect_to @book
    end
  end
  
  def book_params
    params.require(:book).permit(:title, :author, :pages, :description, :url)
  end
end
