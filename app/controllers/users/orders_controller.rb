class Users::OrdersController < ApplicationController
  def index
    @orders = Order.where(user_id: current_user).page(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
  end

  def information
    if current_user.cart_items.blank?
      flash.now[:alert] = "商品をカートに入れてください"
      @cart_items = current_user.cart_items
      @total_price = @cart_items.sum{|cart_item|cart_item.item.price * 1.1 * cart_item.quantity}
      render "cart_items/index"
    end
    @receivers = current_user.receivers.map {|receiver| ["#{receiver.postal_code} #{receiver.prefectures} #{receiver.city} #{receiver.name}", receiver.id]}
  end

  def confirm
    @order = current_user.orders.new(payment: params[:payment])
    @order.shipping_fee = 800
    @order.amount = current_user.cart_items.sum {|cart_item| (cart_item.item.price * cart_item.count) * 1.08} + @order.shipping_fee
    @order_item_sum = @order.amount - @order.shipping_fee
    if params[:send_to] == "0" # ご自身の住所
      @order.postal_code = current_user.postal_code
      @order.prefectures = current_user.prefecture_name
      @order.city = current_user.city
      @order.name = current_user.family_name + current_user.name
    elsif params[:send_to] == "1" # 登録した配送先住所
      receiver = Receiver.find(params[:receiver_id])
      @order.postal_code = receiver.postal_code
      @order.prefectures = receiver.prefectures
      @order.city = receiver.city
      @order.name = receiver.name
    else # 新しいお届け先
      @order.postal_code = params[:postal_code]
      @order.prefectures = params[:prefectures]
      @order.city = params[:city]
      @order.name = params[:name]
    end
    session[:order] = @order
    session[:postal_code] = params[:postal_code]
    session[:prefectures] = params[:prefectures]
    session[:city] = params[:city]
    session[:name] = params[:name]
  end

  def create
    @order = current_user.orders.new(session[:order])
    session[:order] = nil
    if @order.save
      current_user.cart_items.each do |cart_item|
        order_item = @order.order_items.new
        order_item.item_id = cart_item.item.id
        order_item.count = cart_item.count
        order_item.tax_included_price = cart_item.item.price * 1.08
        order_item.save
      end
      if session[:postal_code].present? && session[:prefectures].present? && session[:city].present? && session[:name].present?
        current_user.receivers.create(postal_code: session[:postal_code], prefectures: session[:prefectures], city: session[:city], name: session[:name])
        session[:postal_code] = nil
        session[:prefectures] = nil
        session[:city] = nil
        session[:name] = nil
      end
      current_user.cart_items.destroy_all
      redirect_to complete_orders_path
    else
      render :information
    end
  end

  def complete
  end
end
