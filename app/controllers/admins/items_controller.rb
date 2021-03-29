class Admins::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def new
    @item = Item.new
    @item.item_images.build
  end

  def index
    @items = Item.page(params[:page]).per(12)
  end

  def show
    @item = Item.find(params[:id])
    @average_review = @item.reviews.average(:rate)
    @reviews = @item.reviews.page(params[:page]).per(5)
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admins_items_path
    else
      flash[:notice] = "必要な項目が未入力です"
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admins_items_path
    else
      flash[:notice] = "必要な項目が未入力です"
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :genre_id, :price, :count, :sale_status, item_images_images: [])
  end
end
