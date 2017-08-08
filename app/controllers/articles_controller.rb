# Controller for articles to be published.
class ArticlesController < ApplicationController
  before_action :set_article, only: %i[edit update show destroy]
  before_action :require_admin, only: %i[new create edit update destroy]
  before_action :no_index, only: %i[new edit]

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
    if publishing?
      @article = Article.new(articles_params.merge(published: true,
                                                   created_at: Time.zone.now,
                                                   updated_at: Time.zone.now))
    end

    if @article.save
      flash[:success] = 'Article was successfully created!'
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
    if publishing?
      @article.assign_attributes(articles_params.merge(published: true,
                                                       created_at: Time.zone.now,
                                                       updated_at: Time.zone.now))
    end
    @article.assign_attributes(articles_params.merge(published: false)) if unpublishing?

    if @article.changed?
      if @article.save
        flash[:success] = 'Article was successfully updated!'
        redirect_to article_path(@article)
      else
        render 'edit'
      end
    else
      flash[:info] = 'Article was not updated because no changes were made!'
      redirect_to article_path(@article)
    end
  end

  def destroy
    @article.destroy
    flash[:danger] = 'Article was sucessfully deleted!'
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find_by_slug(params[:id])
    if @article.nil? || (@article.published == false && !logged_in?) || (@article.published == false && !admin?)
      redirect_to articles_path
    end
  end

  def articles_params
    params.require(:article).permit(:title, :content, :meta_data_title,
                                    :meta_data_description, :meta_data_keywords)
  end

  def require_admin
    if logged_in? && !admin?
      flash[:danger] = 'Only admin users can perform that action'
      redirect_to root_path
    end
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
