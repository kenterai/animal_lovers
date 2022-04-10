class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(params[:user_id])
    relationship = current_user.active_relationships.build(follower_id: user.id)
    relationship.save
    redirect_to user_path(user.id)
  end

  def destroy
    user = User.find(params[:user_id])
    relationship = current_user.active_relationships.find_by(follower_id: user.id)
    relationship.destroy
    redirect_to user_path(user.id)
  end
end
