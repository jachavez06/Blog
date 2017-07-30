class ArticlesController < ApplicationController
    before_action :set_article, only: [:edit, :update, :show, :destroy]
    before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]

    def index
        @articles = Article.paginate(page: params[:page], per_page: 1)
        set_meta_tags description: 'A list of all the tutorials I have written.'
        set_meta_tags keywords: 'Blog, Code, Tutorial, Guide, Example, Program'
    end 

    def new
        @article = Article.new
    end 
    
    def create
        @article = Article.new(articles_params)
        if @article.save
		    flash[:success] = "Article was successfully created!"
		    redirect_to article_path(@article) 
		else
		    render 'new'
        end 
    end

    def edit
    end 

    def show
        set_meta_tags title: @article.meta_data_title
        set_meta_tags description: @article.meta_data_description
        set_meta_tags keywords: @article.meta_data_keywords
    end 

    def update
        if @article.update (articles_params)
            flash[:success] = "Article was successfully updated!"
            redirect_to article_path(@article)
        else 
            render 'edit'
        end 
    end 

    def destroy
        @article.destroy
        flash[:danger] = "Article was sucessfully deleted!"
        redirect_to articles_path
    end

    private
    
    def set_article
        @article = Article.find_by_slug(params[:id])
    end 

    def articles_params
        params.require(:article).permit(:title, :content, :meta_data_title, :meta_data_description, :meta_data_keywords)
    end

    def require_admin
        if logged_in? and !current_user.admin?
            flash[:danger] = "Only admin users can perform that action"
            redirect_to root_path
        end
    end
end
