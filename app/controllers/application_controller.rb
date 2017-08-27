# Controller for general purposes.
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user

  helper_method :current_user, :logged_in?, :admin?, :render_404

  def authenticate_user
    # Determine IP
    ip = request.remote_ip

    # Set ip
    session[:ip] = ip
    
    # If lookedup user exists
    if user_lookup(ip)
      # Load user
      User.find_by(ip: ip)
    else
      # Create user
      User.create(:ip => ip)
    end
  end

  def current_user
    User.find_by(ip: request.remote_ip)
  end

  def admin?
    session[:admin] == true
  end

  def user_lookup(ip)
    User.find_by(ip: ip)
  end 
end
