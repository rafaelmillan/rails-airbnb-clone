class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  def show
  end

  def create
    @place = Place.find(params[:place_id])
    @review = Review.new(review_params)
    @review.place = @place
    if @review.save
      redirect_to place_path(@place)
    else
      render "places/show"
    end
  end

  # def edit
  # end

  # def update
  #   if @review.update(review_params)
  #     redirect_to review_path(@review)
  #   else
  #     redirect_to review_path(@review)
  #   end
  # end

  # def destroy
  #   @review.destroy
  # end


  private
  def review_params
    params.require(:review).permit(:content, :rating)
  end

  def set_review
    @review = Review.find(params[:id])
  end

end
