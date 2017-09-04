# /app/controllers/admins_controller.rb
class AdminsController < ApplicationController
  def index
    # Paginate unpublished articles
    @unpublished = Article.where(published: false).paginate(page: params[:page], 
                                 per_page: 10).order(created_at: :desc) if admin?
  end
end
