class SessionsController < ApplicationController
    def new
        
    end 
    
    def create
        user = User.find_by(username: params[:session][:username])
        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id
            flash[:success] = "You have successfully logged in."
            redirect_to articles_path
        else
            flash.now[:danger] = "You have entered an invalid Username/Password."
            render 'new'
        end           
    end 
    
    def destroy
        
    end 
end
