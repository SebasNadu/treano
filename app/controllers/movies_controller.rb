require 'net/http'
require 'uri'
require 'json'

class MoviesController < ApplicationController
  before_action :set_movie, only: [:show]


  def index
    @movies = Movie.all
  end

  def show
    watchmode_info = api_call("https://api.watchmode.com/v1/search/?apiKey=#{ENV['WATCHMODE_API_KEY']}&search_field=tmdb_movie_id&search_value=#{@movie.tmdb_id.to_s}")

    imdb_id = watchmode_info["title_results"][0]["imdb_id"]
    watchmode_id = watchmode_info["title_results"][0]["id"]
    @review = Review.new
    @reviewable = @movie
    @list_item = ListItem.new
    @listable = @movie
    @lists = List.where(["user_id = :user_id", { user_id: current_user.id }])
    @providers
    raise
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def api_call(url)
    uri = URI(url)
    json = Net::HTTP.get(uri)
    result = JSON(json)
  end
end
