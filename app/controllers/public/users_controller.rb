class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show, :follows, :followers]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order('id DESC')
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
       redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  def destroy
    user = current_user
    user.destroy
    redirect_to root_path
  end

  def follows
    @user = User.find(params[:id])
    @users = @user.followings
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile, :profile_image)
  end

end
