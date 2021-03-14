class Users::ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to root_path
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :body, :rate, :item_id)
  end
end
