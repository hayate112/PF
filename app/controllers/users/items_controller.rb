class Users::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(12)
    @genres = Genre.where(genre_status: false)
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @average_review = @item.reviews.average(:rate)
    @reviews = @item.reviews.page(params[:page]).per(5)
    if user_signed_in?
      new_history = @item.item_historys.new
      new_history.user_id = current_user.id
      if current_user.item_historys.exists?(item_id: "#{params[:id]}")
        old_history = current_user.item_historys.find_by(item_id: "#{params[:id]}")
        old_history.destroy
      end
      new_history.save

      histories_stock_limit = 12
      histories = current_user.item_historys.all
      if histories.count > histories_stock_limit
        histories[0].destroy
      end
    end
  end

  def review
    @item = Item.find(params[:id])
    @review = Review.new
    @review.review_images.build
  end

  def item_history
    @historys = ItemHistory.all
  end

  def item_search
    selection = params[:keyword]
    @items = Item.sort(selection)
    @items = Kaminari.paginate_array(@items).page(params[:page]).per(12)
    @genres = Genre.where(genre_status: false)
    render 'users/items/index'
  end

  def item_genre_search
    @value = params["search"]["value"]
    @how = params["search"]["how"]
    @items = search_for(@how, @value)
    @items = Kaminari.paginate_array(@items).page(params[:page]).per(12)
    @genres = Genre.where(genre_status: false)
    render 'users/items/index'
  end

  private

  def match(value)
    Item.where(genre_id: value)
  end

  def search_for(how, value)
    case how
    when 'match'
      match(value)
    end
  end
end
