class ChallengesController < ApplicationController
  before_action :require_login
  before_action :set_challenge, only: [:show, :edit, :update, :destroy, :join, :leave, :leaderboard, :invite, :add_users, :update_goal]
  before_action :require_creator, only: [:edit, :update, :destroy, :invite, :add_users]
  before_action :require_participant, only: [:update_goal]
  
  def index
    @my_challenges = current_user.created_challenges.order(due_date: :asc)
    @participating_challenges = current_user.challenges.order(due_date: :asc)
    @available_challenges = Challenge.where.not(id: @participating_challenges.pluck(:id))
                                    .where.not(creator_id: current_user.id)
                                    .where('due_date >= ?', Date.today)
                                    .order(due_date: :asc)
  end
  
  def show
    @books = @challenge.books.includes(:user, :votes).order(created_at: :desc)
    @is_participant = @challenge.participants.include?(current_user) || @challenge.creator == current_user
    @user_participation = @challenge.challenge_participations.find_by(user: current_user) if @is_participant
  end
  
  def new
    unless current_user.can_create_challenge?
      flash[:alert] = "You cannot create more than 100 challenges"
      redirect_to challenges_path
      return
    end
    @challenge = Challenge.new
  end
  
  def create
    unless current_user.can_create_challenge?
      flash[:alert] = "You cannot create more than 100 challenges"
      redirect_to challenges_path
      return
    end
    
    @challenge = current_user.created_challenges.build(challenge_params)
    
    if @challenge.save
      # Automatically add creator as participant
      @challenge.participants << current_user
      flash[:notice] = "Challenge successfully created!"
      redirect_to @challenge
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
  end
  
  def update
    if @challenge.update(challenge_params)
      flash[:notice] = "Challenge successfully updated!"
      redirect_to @challenge
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @challenge.destroy
    flash[:notice] = "Challenge successfully deleted!"
    redirect_to challenges_path
  end
  
  def join
    if @challenge.participants.include?(current_user)
      flash[:alert] = "You are already participating in this challenge"
    elsif @challenge.active?
      @challenge.participants << current_user
      flash[:notice] = "Successfully joined the challenge!"
    else
      flash[:alert] = "This challenge has already ended"
    end
    redirect_to @challenge
  end
  
  def leave
    if @challenge.creator == current_user
      flash[:alert] = "Challenge creator cannot leave the challenge"
    elsif @challenge.participants.include?(current_user)
      @challenge.participants.delete(current_user)
      flash[:notice] = "Successfully left the challenge"
      redirect_to challenges_path
    else
      flash[:alert] = "You are not participating in this challenge"
      redirect_to @challenge
    end
  end
  
  def leaderboard
    @leaderboard_data = @challenge.participants.map do |participant|
      completed_books = participant.books.where(challenge: @challenge).completed
      completed_count = completed_books.count
      valid_count = completed_books.select { |b| !b.exceeds_veto_threshold? }.count
      total_pages = completed_books.sum(:pages)
      participation = @challenge.challenge_participations.find_by(user: participant)
      
      {
        user: participant,
        completed: completed_count,
        valid: valid_count,
        goal: participation&.book_goal || @challenge.default_book_goal,
        total_pages: total_pages
      }
    end.sort_by { |data| [-data[:valid], data[:user].username] }
    
    render :leaderboard
  end
  
  def invite
    # Get users who are not already participating
    @available_users = User.where.not(id: @challenge.participants.pluck(:id))
  end
  
  def add_users
    user_ids = params[:user_ids]&.reject(&:blank?) || []
    
    if user_ids.empty?
      flash[:alert] = "Please select at least one user to invite"
      redirect_to invite_challenge_path(@challenge)
      return
    end
    
    added_count = 0
    user_ids.each do |user_id|
      user = User.find_by(id: user_id)
      next unless user
      next if @challenge.participants.include?(user)
      
      participation = @challenge.challenge_participations.build(user: user, invited_by: current_user)
      if participation.save
        added_count += 1
      end
    end
    
    if added_count > 0
      flash[:notice] = "Successfully added #{added_count} #{'user'.pluralize(added_count)} to the challenge!"
    else
      flash[:alert] = "No users were added to the challenge"
    end
    
    redirect_to @challenge
  end
  
  def update_goal
    participation = @challenge.challenge_participations.find_by(user: current_user)
    
    if participation.nil?
      flash[:alert] = "You are not participating in this challenge"
      redirect_to @challenge
      return
    end
    
    new_goal = params[:book_goal].to_i
    
    if new_goal <= 0
      flash[:alert] = "Book goal must be greater than 0"
      redirect_to @challenge
      return
    end
    
    if participation.update(book_goal: new_goal)
      flash[:notice] = "Your book goal has been updated to #{new_goal} books!"
    else
      flash[:alert] = "Failed to update your book goal"
    end
    
    redirect_to @challenge
  end
  
  private
  
  def set_challenge
    @challenge = Challenge.find(params[:id])
  end
  
  def require_creator
    unless @challenge.creator == current_user
      flash[:alert] = "Only the challenge creator can perform this action"
      redirect_to @challenge
    end
  end
  
  def challenge_params
    params.require(:challenge).permit(:name, :description, :due_date, :veto_threshold, :default_book_goal)
  end
  
  def require_participant
    unless @challenge.participants.include?(current_user)
      flash[:alert] = "You must be a participant to perform this action"
      redirect_to @challenge
    end
  end
end
