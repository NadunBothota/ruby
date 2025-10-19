class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:uquotes]  # Ensure user is logged in before accessing uquotes

  def index
    @quotes = Quote.includes(:philosopher, :user).limit(5)
  end

  def uquotes
    @quotes = Quote.includes(:philosopher).where(user_id: session[:user_id])
  end

  private

  def authenticate_user!
    unless session[:user_id]
      flash[:alert] = "You need to log in to access this page."
      redirect_to login_path  # Redirect to the login page if not logged in
    end
  end
end

