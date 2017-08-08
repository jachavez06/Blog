# Controller for general purposes.
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :admin?

  def current_user
    user_id = session[:user_id]
    @current_user ||= User.find(user_id) if user_id
  end

  def logged_in?
    !current_user.nil?
  end

  def admin?
    logged_in? ? current_user.admin : false
  end
end
