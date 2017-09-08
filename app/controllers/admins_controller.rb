# /app/controllers/admins_controller.rb
class AdminsController < ApplicationController
  def index
    # Paginate unpublished articles
    if admin?
      @unpublished = Article.where(state: 0).paginate(page: params[:page], per_page: 10).order(created_at: :desc)
    else
      flash[:danger] = "You are not have permission to view that page."
      redirect_to root_path
    end
  end
end
