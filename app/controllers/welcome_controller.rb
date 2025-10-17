class WelcomeController < ApplicationController
  def index
    # If user is logged in, go to challenges
    if logged_in?
      redirect_to challenges_path
      return
    end
    
    # If no admin exists, prompt to create one
    unless User.exists?(admin: true)
      redirect_to admin_signup_path
      return
    end
    
    # Otherwise show login
    redirect_to login_path
  end
end
