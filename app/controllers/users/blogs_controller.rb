class Users::BlogsController < ApplicationController
  def index
    @blogs = Blog.page(params[:page]).per(6)
    @genres = Genre.where(genre_status: true)
  end

  def show
    @blog = Blog.find(params[:id])
    @comment = Comment.new
    @comments = @blog.comments.page(params[:page]).per(5)
    new_history = @blog.blog_historys.new
    new_history.user_id = current_user.id
    if current_user.blog_historys.exists?(blog_id: "#{params[:id]}")
      old_history = current_user.blog_historys.find_by(blog_id: "#{params[:id]}")
      old_history.destroy
    end
    new_history.save

    histories_stock_limit = 10
    histories = current_user.blog_historys.all
    if histories.count > histories_stock_limit
      histories[0].destroy
    end
  end

  def blog_history
    @historys = BlogHistory.all
  end

  def blog_search
    selection = params[:keyword]
    @blogs = Blog.sort(selection)
    @blogs = Kaminari.paginate_array(@blogs).page(params[:page]).per(6)
    @genres = Genre.where(genre_status: true)
    render 'users/blogs/index'
  end

  def blog_genre_search
    @value = params["search"]["value"]
    @how = params["search"]["how"]
    @blogs = search_for(@how, @value)
    @blogs = Kaminari.paginate_array(@blogs).page(params[:page]).per(6)
    @genres = Genre.where(genre_status: true)
    render 'users/blogs/index'
  end

  private

  def match(value)
    Blog.where(genre_id: value)
  end

  def search_for(how, value)
    case how
    when 'match'
      match(value)
    end
  end
end
