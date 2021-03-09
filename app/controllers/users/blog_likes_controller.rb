class Users::BlogLikesController < ApplicationController
  def create
    blog = Blog.find(params[:blog_id])
    blog_like = current_user.blog_likes.new(blog_id: blog.id)
    blog_like.save
    redirect_to blog_path(blog)
  end

  def destroy
    blog = Blog.find(params[:blog_id])
    blog_like = current_user.blog_likes.find_by(blog_id: blog.id)
    blog_like.destroy
    redirect_to blog_path(blog)
  end
end
