class AdminsController < ApplicationController
    def index
        @unpublished = Article.where(published: false) if admin?
    end
end
