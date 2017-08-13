# Controller for creating a admin session.
class SessionsController < ApplicationController
  before_action :no_index, only: [:new]
  before_action :find_admin, only: [:create]
  before_action :authenticate_admin, only: [:create]

  def new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    if @admin && @authenticated
      @old_admin = admin.find_by(ip: request.remote_ip)
      @old_admin.delete
      @old_admin.save

      @admin.ip = request.remote_ip
      @admin.save
      ahoy.authenticate(@admin)
      redirect_to articles_path
    else
      respond_to do |format|
        format.js { render 'create' }
      end
    end
  end

  def destroy
    session[:admin_id] = nil
    session[:ip] = nil
    flash[:success] = 'You have logged out.'
    redirect_to root_path
  end

  private

  def no_index
    set_meta_tags nofollow: true
  end

  def find_admin
    @admin = admin.find_by(login: params[:session][:login])
  end

  def authenticate_admin
    @authenticated = @admin.authenticate(params[:session][:password])
  end
end
