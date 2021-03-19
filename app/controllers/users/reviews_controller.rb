class Users::ReviewsController < ApplicationController
  def create
    item = Item.find(params[:item_id])
    review = current_user.reviews.new(review_params)
    review.item_id = item.id
    if review.save
      redirect_to item_path(item.id)
    end
  end

  def destroy
    Review.find_by(id: params[:id], item_id: params[:item_id]).destroy
    redirect_to item_path(params[:item_id])
  end

  private

  def review_params
    params.require(:review).permit(:title, :body, :rate, :item_id, review_images_images: [])
  end
end
