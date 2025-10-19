class SessionsController < ApplicationController
  def new
  end

  def create
    # Find the user by email
    user = User.find_by(email: params[:email])

    # Check if the user exists
    if user.nil?
      flash.now[:error] = "User not found. Please check your email."
      render 'new' and return
    end

    # If user is found, authenticate and check for active status
    if user.authenticate(params[:password_digest]) && user.status == "active"
      session[:user_id] = user.id
      session[:first_name] = user.first_name
      session[:is_admin] = user.is_admin

      # Redirect based on admin status
      if user.is_admin
        redirect_to admin_path, notice: "Logged in successfully as Admin!"
      else
        redirect_to userhome_path, notice: "Logged in successfully!"
      end
    else
      # Check if the password is incorrect or the account is inactive
      if user.status != "active"
        flash.now[:error] = "Your account is inactive. Please contact support."
      else
        flash.now[:error] = "Invalid password. Please try again."
      end
      render 'new'
    end
  end

  def destroy
    # Clear session data upon logout
    session[:user_id] = nil
    session[:first_name] = nil
    session[:is_admin] = nil
    redirect_to root_path, notice: "Logged out successfully!"
  end
end

