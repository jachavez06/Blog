# /app/controllers/admins_controller.rb
class AdminsController < ApplicationController
  def index
    # Paginate unpublished articles
    @unpublished = Article.where(published: false).paginate(page: params[:page], 
                                 per_page: 10) if admin?
  en
end
