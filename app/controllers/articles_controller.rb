class ArticlesController < ApplicationController

    def index
        @articles = Article.all
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
    end 

    def destroy
    end

    private

    def articles_params
        params.require(:article).permit(:title, :content)
    end
end
