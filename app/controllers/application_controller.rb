# Controller for general purposes.
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user

  helper_method :current_user, :logged_in?, :admin?, :render_404

  def authenticate_user
    # Determine IP
    @ip ||= request.remote_ip


    @user = User.find_or_create_by(:ip => @ip)

    ahoy.authenticate(@user)
  end

  def current_user
    @current_user ||= User.find_by(ip: @ip)
  end

  def admin?
    @admin ||= current_user.admin_id != nil
  end
end
