class Admins::BlogsController < ApplicationController
  def new
    @blog = Blog.new
  end

  def index
    @blogs = Blog.all
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      redirect_to admins_blogs_path
    end
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      redirect_to admins_blog_path(@blog.id)
    end
  end

  def destroy
    blog = Blog.find(params[:id])
    blog.destroy
    redirect_to admins_blogs_path
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :body, :genre_id)
  end
end
