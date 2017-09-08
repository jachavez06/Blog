# Controller for general purposes.
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user

  def authenticate_user
    ahoy.authenticate(current_user)
  end

  def ip
    @_ip ||= request.remote_ip
  end

  def current_user
    @_current_user ||= User.find_or_create_by(ip: ip)
  end

  def admin?
    @_admin ||= session[:admin].present? ? session[:admin] : false
  end
end
