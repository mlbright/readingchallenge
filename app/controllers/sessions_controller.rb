class SessionsController < ApplicationController
  def new
    # Login form
  end

  def create
    user = User.find_by(email: params[:email])
    
    if user.nil?
      flash.now[:alert] = "Invalid email or password"
      render :new, status: :unprocessable_entity
      return
    end
    
    # Check if user needs to set up password
    if user.needs_password_setup?
      session[:setup_user_id] = user.id
      redirect_to setup_password_path
      return
    end
    
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Successfully logged in!"
      redirect_to root_path
    else
      flash.now[:alert] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end
  
  def setup_password
    @user = User.find_by(id: session[:setup_user_id])
    
    unless @user&.needs_password_setup?
      redirect_to login_path
      return
    end
  end
  
  def complete_setup
    @user = User.find_by(id: session[:setup_user_id])
    
    unless @user&.needs_password_setup?
      redirect_to login_path
      return
    end
    
    if @user.update(password: params[:password], password_confirmation: params[:password_confirmation])
      session.delete(:setup_user_id)
      session[:user_id] = @user.id
      flash[:notice] = "Password set successfully! Welcome to Reading Challenge."
      redirect_to root_path
    else
      flash.now[:alert] = @user.errors.full_messages.join(", ")
      render :setup_password, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out successfully"
    redirect_to login_path
  end
end
