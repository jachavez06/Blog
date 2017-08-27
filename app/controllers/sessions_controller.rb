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
      # Set admin cookie
      session[:admin] = true

      # Associate admin to current user
      @admin.users << current_user

      @admin.users.map{ 
        |a| a.ip = request.remote_ip
      }

      # Tell ahoy to track this change
      #ahoy.authenticate(@admin)

      # Redirect
      redirect_to articles_path
    else
      # Respond with error message
      respond_to do |format|
        format.js { render 'create' }
      end
    end
  end

  def destroy
    session[:admin] = nil
    flash[:success] = 'You have logged out.'
    redirect_to root_path
  end

  private

  def no_index
    set_meta_tags nofollow: true
  end

  def find_admin
    @admin = Admin.find_by(login: params[:session][:login])
  end

  def authenticate_admin
    @authenticated = @admin.authenticate(params[:session][:password])
  end
end
