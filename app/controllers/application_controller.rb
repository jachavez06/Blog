# Controller for general purposes.
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user

  helper_method :current_user, :logged_in?, :admin?

  def authenticate_user
    # Do nothing if current_user is set.
    return if current_user.present?

    # Determine IP
    ip = request.remote_ip

    # Set IP cookie. 
    session[:ip] = ip

    # Add User to table.
    User.create(:ip => ip)
  end

  def current_user
    ip = session[:ip]
    User.find_by(ip: ip)
  end

  def admin?
    session[:admin] == true
  end

  rescue_from ActionController::RoutingError do |exception|
    logger.error 'Routing error occurred'
    render 'errors/404'
   end
end
