class Users::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
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

  def review
    @item = Item.find(params[:id])
    @review = Review.new
    @review.review_images.build
  end

  def item_history
    @historys = ItemHistory.all
  end
end
