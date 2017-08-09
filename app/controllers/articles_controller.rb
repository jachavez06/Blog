# Controller for articles to be published.
class ArticlesController < ApplicationController

  before_action :set_article, only: %i[edit update show destroy]
  before_action :require_admin, only: %i[new create edit update destroy]
  before_action :no_index, only: %i[new edit]

  @@flash_messages = {updated: "Article was successfully updated!",
                      no_change: "Article was not updated because no changes were made!",
                      created:  "Article was successfully created!" }

  def index
    @articles = Article.where(published: true).paginate(page: params[:page],
                                                        per_page: 10)
    set_meta_tags description: 'A list of all the tutorials I have written.'
    set_meta_tags keywords: 'Blog, Code, Tutorial, Guide, Example, Program'

    @unpublished = Article.where(published: false) if admin?
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
    @article.make_publishable(articles_params) if publishing?
    @article.make_unpublishable(articles_params) if unpublishing?
    # Next line adds to cyclomatic complexity but shortens block to acceptable
    
    (flash[:info] = @@flash_messages[:no_change]) && render('edit') && return unless !@article.changed?

    if @article.save && @article.assign_attributes(articles_params)
      flash[:success] = @@flash_messages[:updated]
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    flash[:danger] = 'Article was sucessfully deleted!'
    redirect_to articles_path
  end

  private

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

    redirect_to article_path
  end

  def articles_params
    params.require(:article).permit(:title, :content, :meta_data_title,
                                    :meta_data_description, :meta_data_keywords)
  end

  def require_admin
    return unless logged_in? && !admin?
    flash[:danger] = 'Only admin users can perform that action!'
    redirect_to root_path
  end

  def no_index
    set_meta_tags nofollow: true
  end

  def publishing?
    params[:commit] == 'Publish'
  end

  def unpublishing?
    params[:commit] == 'Unpublish'
  end
end
