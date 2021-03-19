class Admins::OrdersController < ApplicationController
  def index
    @orders = Order.page(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      redirect_to admins_order_path(@order.id)
    end
  end

  private

  def order_params
    params.require(:order).permit(:shipping_status)
  end
end
