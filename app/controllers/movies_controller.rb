class MoviesController < ApplicationController
  def show
    @test_review = PolyReviewTest.new()
    @movie = Movie.find(params[:id])
  end
end
