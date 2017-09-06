# Controls filtering by tags
class FiltersController < ApplicationController
  def show
    @articles = Article.where(state: 1).tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 10).order(created_at: :desc)
    @tags = ActsAsTaggableOn::Tag.all
  end
end
