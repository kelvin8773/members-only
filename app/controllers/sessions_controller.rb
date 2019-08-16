class SessionsController < ApplicationController  
    def new
    end

    def create
        user = User.find_by(email: params[:session][:email].downcase)
        
        if user && !!user.authenticate(params[:session][:password])
            log_in(user)
            params[:session][:remember_me] == '1' ? remember(user) : forget(user) 
            flash[:success] = 'You are logged in!'
            redirect_back_or root_url
        elsif user.nil?
            flash.now[:warning] = 'This user is not register!!'
            render 'new'
        else
            flash.now[:danger] = 'Invalid email/password combination.'
            render 'new'
        end
    end

    def delete
        log_out if logged_in?
        flash[:success] = 'You have just signed out!'
        redirect_to login_path
    end

    

    
end
