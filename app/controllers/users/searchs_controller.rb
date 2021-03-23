class Users::SearchsController < ApplicationController
  def search
    content = params[:content]
    model = params[:model]
    if model == "Item"
      @items = Item.where("name LIKE ?", "%#{content}%").page(params[:page]).per(12)
      render 'users/items/index'
    else
      @blogs = Blog.where("title LIKE ?", "%#{content}%").page(params[:page]).per(6)
      render 'users/blogs/index'
    end
  end
end
