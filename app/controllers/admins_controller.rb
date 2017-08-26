class AdminsController < ApplicationController
    def index
        @unpublished = Article.where(published: false).paginate(:page => params[:page], :per_page => 10) if admin?
    end
end
