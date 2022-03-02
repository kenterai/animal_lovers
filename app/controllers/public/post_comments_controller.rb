class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @post_comment = current_user.post_comments.build(post_comment_params)
    @post_comment.post_id = @post.id
    if @post_comment.save
       redirect_to post_path(@post.id)
    else
       render "public/posts/show"
    end
  end

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to post_path(params[:post_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
