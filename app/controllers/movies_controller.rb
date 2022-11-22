require 'net/http'
require 'open-uri'
require 'json'

class MoviesController < ApplicationController
  before_action :set_movie, only: [:show]


  def index
    @movies = Movie.all
  end

  def show
    @review = Review.new
    @reviewable = @movie
    @list_item = ListItem.new
    @listable = @movie
    @lists = List.where(["user_id = :user_id", { user_id: current_user.id }])
    #raise
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

end
