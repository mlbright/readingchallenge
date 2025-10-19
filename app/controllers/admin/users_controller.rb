class Admin::UsersController < ApplicationController
  before_action :require_login
  before_action :require_admin

  def index
    @users = User.order(created_at: :desc)
  end

  def new
    @user = User.new
  end

  def create
    # Generate a username from email if not provided
    username = params[:user][:username].presence || params[:user][:email].split("@").first

    @user = User.new(
      username: username,
      email: params[:user][:email],
      admin: params[:user][:admin] == "1"
    )

    # Don't set password - user will set it on first login
    @user.password_digest = nil

    # Skip password validation for admin-created users
    if @user.save(validate: false)
      # Now validate to catch username/email errors
      unless @user.valid?
        @user.destroy
        flash.now[:alert] = @user.errors.full_messages.join(", ")
        render :new, status: :unprocessable_entity
        return
      end

      flash[:notice] = "User successfully created! They will set their password on first login."
      redirect_to admin_users_path
    else
      flash.now[:alert] = @user.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user == current_user
      flash[:alert] = "You cannot delete yourself!"
      redirect_to admin_users_path
      return
    end

    @user.destroy
    flash[:notice] = "User successfully deleted!"
    redirect_to admin_users_path
  end

  private

  def require_admin
    unless current_user&.admin
      flash[:alert] = "You must be an administrator to access this page"
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:username, :email)
  end
end
