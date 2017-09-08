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

    # Check if tag is published
    return if Rails.cache.read('published_tags').include? @tag

    # If here, then user tried to access unpublished or non-existent tag.
    redirect_to root_path
  end
end
