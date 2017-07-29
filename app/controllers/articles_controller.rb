class ArticlesController < ApplicationController
    before_action :set_article, only: [:edit, :update, :show, :destroy]
    before_action :require_admin, only: [:new]

    def index
        @articles = Article.paginate(page: params[:page], per_page: 1)
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
        params.require(:article).permit(:title, :content)
    end

    def require_admin
        if logged_in? and !current_user.admin?
            flash[:danger] = "Only admin users can perform that action"
            redirect_to root_path
        end
    end
end
