# Controls filtering by tags
class FiltersController < ApplicationController
  before_action :require_published

  def show
    @articles = Article.where(state: 1).tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 10).order(created_at: :desc)
    @tags = @articles.tag_counts_on(:tags)
  end

  private

  def require_published

  end
end
