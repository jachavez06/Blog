class SessionsController < ApplicationController
    before_action :no_index, only: [:new]

    def new
        respond_to do |format|
            format.html
            format.js
        end
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
        session[:user_id] = nil
        flash[:success] = "You have logged out."
        redirect_to root_path
    end

    private
    def no_index
        set_meta_tags nofollow: true    
    end

end
