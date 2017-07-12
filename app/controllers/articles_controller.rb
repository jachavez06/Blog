class ArticlesController < ApplicationController

    def index
        @articles = Article.paginate(page: params[:page], per_page: 10)
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
        @article = Article.find(params[:id])
    end 

    def show
        @article = Article.find(params[:id])
    end 

    def update
        @article = Article.find(params[:id])
        if @article.update (articles_params)
            flash[:success] = "Article was successfully updated!"
            redirect_to article_path(@article)
        else 
            render 'edit'
        end 
    end 

    def destroy
    end

    private

    def articles_params
        params.require(:article).permit(:title, :content)
    end
end
