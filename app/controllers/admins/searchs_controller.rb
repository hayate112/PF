class Admins::SearchsController < ApplicationController
  def search
    content = params[:content]
    model = params[:model]
    if model == "User"
      @users = User.where("email LIKE ?", "%#{content}%").\
        or(User.where(" family_name||name LIKE ?", "%#{content}%")).\
        or(User.where(" family_name_kana||name_kana LIKE ?", "%#{content}%")).\
        page(params[:page]).per(20)
      render 'admins/users/index'
    elsif model == "Item"
      @items = Item.where("name LIKE ?", "%#{content}%").page(params[:page]).per(12)
      render 'admins/items/index'
    else
      @blogs = Blog.where("title LIKE ?", "%#{content}%").page(params[:page]).per(6)
      render 'admins/blogs/index'
    end
  end
end
