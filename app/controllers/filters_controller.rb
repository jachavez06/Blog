# Controls filtering by tags
class FiltersController < ApplicationController
  before_action :require_published, only: [:show]

  def show
    @articles = Article.where(state: 1).tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 10).order(created_at: :desc)
    @tags = @articles.tag_counts_on(:tags)
  end

  private

  def require_published
    # Save param so don't have to access it again
    @tag = params[:tag]

    return if Rails.cache.read('published_tags').include? @tag

    # If they reach this point, then they tried to reach a tag that has not been published or does not exist
    redirect_to root_path
  end
end
