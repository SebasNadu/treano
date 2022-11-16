class ReviewsController < ApplicationController
  before_action :set_reviewable

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.reviewable = @reviewable
    if @review.save
      redirect_to polymorphic_path(@reviewable)
    else
      @review = Review.new
      render "movies/show", status: :unprocessable_entity
    end
  end

  # def edit
  #   @review = Review.find(params[:id])
  # end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to polymorphic_path(@review.reviewable), status: :see_other
  end

  private

  def set_reviewable
    if params[:movie_id].present?
      @reviewable = Movie.find(params[:movie_id])
    elsif params[:tv_id].present?
      @reviewable = Tv.find(params[:tv_id])
    end
  end

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end
