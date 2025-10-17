class VotesController < ApplicationController
  before_action :require_login
  before_action :set_book
  
  def create
    @vote = @book.votes.build(user: current_user, approved: params[:approved])
    
    if @vote.save
      flash[:notice] = "Vote recorded!"
    else
      flash[:alert] = @vote.errors.full_messages.join(", ")
    end
    
    redirect_to @book
  end

  def destroy
    @vote = @book.votes.find_by(user: current_user)
    if @vote
      @vote.destroy
      flash[:notice] = "Vote removed!"
    end
    
    redirect_to @book
  end
  
  private
  
  def set_book
    @book = Book.find(params[:book_id])
  end
end
