class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    
    if @post.save
      redirect_to root_url
    else
      flash.now[:error] = "Post Can't save!"
      render :new
    end

  end

  def index
    @posts = Post.order(created_at: :desc)
  end

  private

  def logged_in_user
    unless logged_in?
      flash[:error] = "Please sign in first!"
      redirect_to login_path
    end
  end

  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end

end
