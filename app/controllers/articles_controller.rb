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
    @articles = Article.where(state: 1).paginate(:page => params[:page], :per_page => 10).order(created_at: :desc)
    set_meta_tags description: 'A list of all the tutorials I have written.'
    set_meta_tags keywords: 'Blog, Code, Tutorial, Guide, Example, Program'
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(articles_params)
    @article.make_publishable(articles_params) if publishing?

    if @article.save
      flash[:success] = @@flash_messages[:created]
      redirect_to article_path(@article)
    else
      @article.state = :draft
      render 'new'
    end
  end

  def edit; end

  def show
    set_meta_tags title: @article.meta_data_title
    set_meta_tags description: @article.meta_data_description
    set_meta_tags keywords: @article.meta_data_keywords
    set_meta_tags canonical: request.original_url
  end

  def update
    @article.assign_attributes(articles_params)
    if publishing?
      @article.make_publishable(articles_params)
    elsif unpublishing?
      @article.make_unpublishable(articles_params)
    else
      @article.assign_attributes(articles_params)
      unless @article.edited?
        (flash.now[:info] = @@flash_messages[:no_change])
        render('edit')
        return
      end
    end
    save_article
  end

  def destroy
    @article.destroy
    flash[:danger] = 'Article was sucessfully deleted!'
    redirect_to articles_path
  end

  private

  def save_article
    if @article.save
      flash[:success] = @@flash_messages[:updated]
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  # Load article if it exists in db.
  def set_article
    slug = params[:id]
    if Article.article_exists?(slug)
      article = Article.find_by_slug(slug)
      if admin? || Article.article_published?(article)
        @article = article
        return
      end
    end
  end

  def articles_params
    params.require(:article).permit(:title, :content, :meta_data_title,
                                    :meta_data_description, :meta_data_keywords,
                                    :created_at, :updated_at, :tag_list)
  end
end
