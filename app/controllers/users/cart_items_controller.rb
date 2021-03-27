class Users::CartItemsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @cart_item = CartItem.new
    @cart_items = current_user.cart_items
    @total_price = 0
  end

  def create
    @cart_item = CartItem.new(cart_params)
    @cart_item.user_id = current_user.id
    if @cart_item.save
      redirect_to cart_items_path
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_params)
      redirect_to cart_items_path
    end
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    cart_item = CartItem.where(user_id: current_user.id)
    cart_item.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_params
    params.require(:cart_item).permit(:count, :item_id)
  end
end
