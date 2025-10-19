class RegistrationsController < ApplicationController
  # One-time site administrator signup
  def admin_signup
    # If any admin exists, redirect away
    if User.exists?(admin: true)
      flash[:alert] = "Site administrator already exists. Please contact your administrator."
      redirect_to login_path
      nil
    end
  end

  def create_admin
    # Double-check no admin exists
    if User.exists?(admin: true)
      flash[:alert] = "Site administrator already exists."
      redirect_to login_path
      return
    end

    @user = User.new(
      username: params[:username],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      admin: true
    )

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome! You are now the site administrator."
      redirect_to root_path
    else
      flash.now[:alert] = @user.errors.full_messages.join(", ")
      render :admin_signup, status: :unprocessable_entity
    end
  end

  # Regular user activation (must be pre-created by admin)
  def activation
  end

  def create
    # Find user by email
    @user = User.find_by(email: params[:email])

    if @user.nil?
      flash.now[:alert] = "No account found with this email. Please contact your administrator to create an account for you."
      render :activation, status: :unprocessable_entity
      return
    end

    # Check if user already has a password
    unless @user.needs_password_setup?
      flash.now[:alert] = "This account already has a password set. Please use the login page."
      render :activation, status: :unprocessable_entity
      return
    end

    # Set the password
    if @user.update(password: params[:password], password_confirmation: params[:password_confirmation])
      session[:user_id] = @user.id
      flash[:notice] = "Account activated! Welcome to Reading Challenge."
      redirect_to root_path
    else
      flash.now[:alert] = @user.errors.full_messages.join(", ")
      render :activation, status: :unprocessable_entity
    end
  end
end
