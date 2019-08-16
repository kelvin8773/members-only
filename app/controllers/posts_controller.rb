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

  def destroy
    # @micropost.destroy
    Post.find(params[:id]).destroy
    flash[:success] = "Your Post Has Been Deleted."
    redirect_to request.referrer || root_url
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end

end
