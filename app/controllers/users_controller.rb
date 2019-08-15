class UsersController < ApplicationController
  def new
    @page_title = 'Add User'
    @user = User.new
  end

  def create
     @user = User.new(user_params)
     if @user.save
      flash[:notice] = 'User created'
      redirect_to root_url
     else 
      render 'new'
     end
  end

  def show
    if logged_in?
      @user = current_user
    end
  end

  private 
    def  user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end 

end
