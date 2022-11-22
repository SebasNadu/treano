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
    @providers = @movie.providers
    @media_providers = @movie.media_providers
    @free_providers = @providers.where(service: "free").uniq
    @sub_providers = @providers.where(service: "sub").uniq
    @purchase_providers = @providers.where(service: "purchase").uniq
    @tve_providers = @providers.where(service: "tve").uniq
    #raise
  end

  private

  def set_movie
    @movie = Movie.includes(:media_providers).find(params[:id])
  end

end
