class Users::CommentLikesController < ApplicationController
  def create
    comment = Comment.find(params[:comment_id])
    comment_like = current_user.comment_likes.new(comment_id: comment.id)
    comment_like.save
    redirect_to blog_path(blog)
  end

  def destroy
    comment = Comment.find(params[:comment_id])
    comment_like = current_user.comment_likes.find_by(comment_id: comment.id)
    comment_like.destroy
    redirect_to blog_path(blog)
  end
end
