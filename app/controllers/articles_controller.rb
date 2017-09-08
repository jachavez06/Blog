# Controller for articles to be published.
class ArticlesController < ApplicationController
  include Publishable
  include Trackable
  include Viewable
  before_action :set_article, only: %i[edit update show destroy]
  before_action :require_admin, only: %i[new create edit update destroy]
  before_action :no_index, only: %i[new edit]

  @@flash_messages =
    { updated: 'Article was successfully updated!',
      no_change: 'Article was not updated because no changes were made!',
      created:  'Article was successfully created!',
      save_error: 'An internal error occured while trying to save  changes!' }

  def index
    # Load cache
    published = Rails.cache.read('published_articles')

    # Articles
    @articles = published.paginate(page: params[:page], per_page: 10)
    @articles = @articles.order(created_at: :desc)

    # Tags
    @tags = published.tag_counts_on(:tags)

    # Metadata
    set_meta_tags description: 'A list of all the tutorials I have written.'
    set_meta_tags keywords: 'Blog, Code, Tutorial, Guide, Example, Program'
  end

  def new
    # Create new article object so user can populate
    @article = Article.new
  end

  def create
    # Create article from input params
    @article = Article.new(articles_params)

    # Set state if publishing
    update_state if publishing?

    # Attempt to save article
    if @article.save
      # Flash message
      flash[:success] = @@flash_messages[:created]

      # Redirect to article's show page
      redirect_to article_path(@article)
    else
      # Undo make_publishable if occurred
      @article.state = :draft

      # Render new action so they can fix errors
      render 'new'
    end
  end

  def edit; end

  def show
    # Redirect to root_path if article does not exist
    redirect_to root_path && return unless defined? @article

    # Add meta tags
    set_meta_tags title: @article.meta_data_title
    set_meta_tags description: @article.meta_data_description
    set_meta_tags keywords: @article.meta_data_keywords
    set_meta_tags canonical: request.original_url

    # Increase view count
    impressionist(@article)
  end

  def update
    # Update attributes
    @article.assign_attributes(articles_params)

    # Hold previous state in case update fails
    @previous_state = @article.state

    # Content does not need to be updated
    if publishing? || unpublishing?
      update_state
    # Content needs to be updated
    else
      throw_unchanged_error && return unless @article.edited?
    end

    save_article
  end

  def destroy
    @article.destroy
    flash[:danger] = 'Article was sucessfully deleted!'
    redirect_back fallback_location: articles_path
  end

  private

  def update_state
    if publishing?
      @article.make_publishable
    else
      @article.make_unpublishable
    end
  end

  def throw_unchanged_error
    (flash.now[:info] = @@flash_messages[:no_change])
    render('edit')
  end

  def save_article
    if @article.save
      flash[:success] = @@flash_messages[:updated]
      redirect_to article_path(@article)
    else
      # Revert to previous state
      @article.state = @previous_state
      render 'edit'
    end
  end

  # Load article if exists
  def set_article
    slug = params[:id]
    return unless Article.exists?(slug: slug)
    return unless Rails.cache.read('published_articles').any? do |a|
      a.slug == slug
    end || admin?
    @article = Article.find_by_slug(slug)
  end

  # Strong params
  def articles_params
    params.require(:article).permit(:title, :content, :meta_data_title,
                                    :meta_data_description, :meta_data_keywords,
                                    :created_at, :updated_at, :tag_list)
  end
end
