class Admins::ItemsController < ApplicationController
  def new
    @item = Item.new
    @item.item_images.build
  end

  def index
    @items = Item.page(params[:page]).per(12)
  end

  def show
    @item = Item.find(params[:id])
    @average_review = @item.reviews.average(:rate).round(2)
    @reviews = @item.reviews.page(params[:page]).per(5)
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admins_items_path
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admins_items_path
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :genre_id, :price, :count, :sale_status, item_images_images: [])
  end

end
