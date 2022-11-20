class ReviewsController < ApplicationController
  before_action :set_reviewable

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.reviewable = @reviewable
    respond_to do |format|
      if @review.save
        format.html { redirect_to polymorphic_path(@reviewable) }
        format.json
      else
        format.html { render "#{@review.reviewable_type.downcase.pluralize}/show", status: :unprocessable_entity }
        format.json
      end
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    @review.reviewable = @reviewable
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to polymorphic_path(@reviewable) }
        format.json
      else
        format.html { render "movies/show", status: :unprocessable_entity }
        format.json
      end
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    respond_to do |format|
      format.html { render "movies/show", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def set_reviewable
    if params[:movie_id].present?
      @reviewable = Movie.find(params[:movie_id])
    elsif params[:tv_id].present?
      @reviewable = Tv.find(params[:tv_id])
    end
  end

  # def set_reviewable
  #   if params[:movie_id].present?
  #     @reviewable = Movie.find(params[:movie_id])
  #   elsif params[:tv_id].present?
  #     @reviewable = Tv.find(params[:tv_id])
  #   end
  # end

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end
