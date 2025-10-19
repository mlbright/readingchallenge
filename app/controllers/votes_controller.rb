class VotesController < ApplicationController
  before_action :require_login
  before_action :set_challenge
  before_action :set_book

  def create
    @vote = @book.votes.build(user: current_user, veto_reason: params[:veto_reason])

    if @vote.save
      flash[:notice] = "Veto recorded!"
    else
      flash[:alert] = @vote.errors.full_messages.join(", ")
    end

    redirect_to challenge_book_path(@challenge, @book)
  end

  def destroy
    @vote = @book.votes.find_by(user: current_user)
    if @vote
      @vote.destroy
      flash[:notice] = "Veto removed!"
    end

    redirect_to challenge_book_path(@challenge, @book)
  end

  private

  def set_challenge
    @challenge = Challenge.find(params[:challenge_id])
  end

  def set_book
    @book = @challenge.books.find(params[:book_id])
  end
end
