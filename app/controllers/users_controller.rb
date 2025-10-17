class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books.order(created_at: :desc)
    # Include both created challenges and participating challenges
    @challenges = (@user.created_challenges + @user.challenges).uniq.sort_by(&:created_at).reverse
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to Reading Challenge!"
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
