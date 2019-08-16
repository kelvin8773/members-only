class UsersController < ApplicationController
  before_action :logged_in_user,  only: [:index, :edit, :update, :destroy]
  before_action :correct_user,    only: [:edit, :update]
  before_action :admin_user,      only: :destroy


  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)  #Not the final implementation!
    if @user.save
      flash[:info] = "You Account have been created!"
      log_in(@user)
      redirect_to root_url
    else
      flash.now[:danger] = "Something went wrong, Try again!"
      render 'new'
    end
  end

  def show
    if logged_in?
      @user = current_user
      @posts = @user.posts.all
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

<<<<<<< HEAD
  private 
    def  user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end 
=======
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit( :name, 
      :email, 
      :password, 
      :password_confirmation )
  end

  def correct_user
    @user = User.find_by(id: params[:id])
    redirect_to(root_url) unless is_current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
>>>>>>> user-model-refine

end
