module SessionsHelper
  def logged_in?
    !!session[:user_id]
  end

  def is_administrator?
    current_user && current_user.admin?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
