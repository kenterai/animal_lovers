class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @categories = Category.all
    @posts = Post.page(params[:page]).order('id DESC')
    if params[:category_id]
      @category = @categories.find(params[:category_id])
      @posts = @posts.where(category: @category)
    end
  end
end
