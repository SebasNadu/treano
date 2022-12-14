class ReviewsController < ApplicationController
  before_action :set_reviewable

  def create
    @review = Review.new(review_params)
    @user = current_user
    @review.user = @user
    @review.reviewable = @reviewable
    respond_to do |format|
      if @review.save
        #@user.reputation_score +=  20
        #@user.save
        # @user.add_points(20, category: 'reviews')
        # @user.reputation_score = @user.points
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
    @review.update(review_params)
    render partial: "reviews/review", locals: { review: @review }
    # respond_to do |format|
    #   format.html { redirect_to user_dashboard_path(@review.user) }
    #   format.text { render partial: "reviews/review", locals: { review: @review }, formats: [:html] }
    # end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to user_dashboard_path(current_user), status: :see_other
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
