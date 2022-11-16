class ReviewsController < ApplicationController
  before_action :set_reviewable

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.reviewable = @reviewable
    if @review.save
      redirect_to movie_path(Movie.find(params[:movie_id]))
    else
      @review = Review.new
      render "movies/show", status: :unprocessable_entity
    end
  end

  private

  # def set_reviewable
  #   if params[:controller] == "movies"
  #     @reviewable = Movie.find(params[:id])
  #   elsif params[:controller] == "tvs"
  #     @reviewable = Tv.find(params[:id])
  #   end
  # end

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
