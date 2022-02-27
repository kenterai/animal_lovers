class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def confirm
    @post = current_user.posts.build(post_params)
    if @post.invalid?
      render :new
    end
  end

  def create
  end

  def show
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:image, :text, :category_id)
  end

end
