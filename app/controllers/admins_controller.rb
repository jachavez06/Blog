class AdminsController < ApplicationController
    def index
        @unpublished = Article.where(published: false).paginate(:page => params[:page], :per_page => 1) if admin?
    end
end
