class Users::SearchsController < ApplicationController
  def search
    content = params[:content]
    model = params[:model]
    if model == "Item"
      @items = Item.where("name LIKE ?", "%#{content}%").page(params[:page]).per(12)
      @genres = Genre.where(genre_status: false)
      render 'users/items/index'
    else
      @blogs = Blog.where("title LIKE ?", "%#{content}%").page(params[:page]).per(6)
      @genres = Genre.where(genre_status: true)
      render 'users/blogs/index'
    end
  end
end
