class Users::CommentsController < ApplicationController
  def create
    blog = Blog.find(params[:blog_id])
    comment = current_user.comments.new(comment_params)
    comment.blog_id = blog.id
    comment.save
    redirect_to blog_path(blog)
  end

  def destroy
    Comment.find_by(id: params[:id], blog_id: params[:blog_id]).destroy
    redirect_to blog_path(params[:blog_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
