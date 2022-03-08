class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :rank]

  def index
    @categories =Category.all
    @posts = Post.all.order('id DESC')
    if params[:category_id]
      @category = @categories.find(params[:category_id])
      @posts = @posts.where(category: @category)
    end
  end

  def rank
    @categories =Category.all
    @posts = Post.all
    if params[:category_id]
      @category = @categories.find(params[:category_id])
      @posts = @posts.where(category: @category)
    end
    ids = Favorite.group(:post_id).order('count(post_id) desc').pluck(:post_id)
    @posts = @posts.where(id: ids).sort_by { |o| ids.index(o.id) }
  end

  def follows
    @categories =Category.all
    @posts = Post.where(user_id: [*current_user.following_ids]).order('id DESC')
    if params[:category_id]
      @category = @categories.find(params[:category_id])
      @posts = @posts.where(category: @category)
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
       redirect_to post_path(@post.id)
    else
       render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to user_path(current_user.id)
  end

  private

  def post_params
    params.require(:post).permit(:image, :text, :category_id)
  end

end
