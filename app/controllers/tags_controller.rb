# Controls filtering by tags
class TagsController < ApplicationController
  def show
    @articles = Article.where(state: 1).tagged_with(Tag.find(params[:id])).paginate(:page => params[:page], :per_page => 10).order(created_at: :desc)
  end
end
