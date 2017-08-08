# Controller for creating a user session.
class SessionsController < ApplicationController
  before_action :no_index, only: [:new]
  before_action :find_user, only: [:create]
  before_action :authenticate_user, only: [:create]

  def new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    if @user && @authenticated
      session[:user_id] = @user.id
      redirect_to articles_path
    else
      respond_to do |format|
        format.js { render 'create' }
      end
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'You have logged out.'
    redirect_to root_path
  end

  private

  def no_index
    set_meta_tags nofollow: true
  end

  def find_user
    @user = User.find_by(username: params[:session][:username])
  end

  def authenticate_user
    @authenticated = @user.authenticate(params[:session][:password])
  end
end
