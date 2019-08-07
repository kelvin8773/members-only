class SessionsController < ApplicationController
    def new
        user = User.authentication(params[:email], params[:password])
    end

    def create
    end

    def destroy
    end

end
