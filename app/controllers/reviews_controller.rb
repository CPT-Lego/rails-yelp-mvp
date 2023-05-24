class ReviewsController < ApplicationController
  before_action :set_restaurant, only: %i[new create]
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  def index
    @reviews = @restaurant.reviews
  end

  def show
  end

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.restaurant = @restaurant
    if @review.save
      redirect_to restaurant_path(@restaurant), notice: "Review was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @review.update(review_params)
      redirect_to new_restaurant_review_path(@restaurant, @review), notice: "Review was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @review.destroy
    redirect_to restaurant_reviews_path(@restaurant), notice: "Review was successfully destroyed."
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def set_review
    @review = @restaurant.reviews.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
