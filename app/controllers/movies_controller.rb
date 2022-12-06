require 'net/http'
require 'open-uri'
require 'json'

class MoviesController < ApplicationController
  before_action :set_movie, only: [:show]
  skip_before_action :verify_authenticity_token, :only => [:toggle_favorite]

  def index
    @q = Movie.ransack(params[:q])
    @q.sorts = ['popularity desc'] if @q.sorts.empty?
    scope = @q.result(distinct: true).includes(:keywords, :genres, :providers)
    @pagy, @movies = pagy(scope, items: 18)
    @keywords = []
    keywords_map = @movies.map { |movie| movie.keywords.each { |keyword| @keywords << keyword } }
    @keywords.uniq!
    respond_to do |f|
      f.turbo_stream
      f.html
    end
    #raise
  end

  def show
    create_similars(@movie)
    create_recommendations(@movie)
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
    if params[:check].present?
      noti = LinkNotification.with(user: user, badge: badge, granted_at: granted_at)
      noti.deliver(user)
    end
    #raise
  end

  def toggle_favorite
    @movie = Movie.find(params[:id])
    current_user.favorited?(@movie) ? current_user.unfavorite(@movie) : current_user.favorite(@movie)
    respond_to do |format|
      format.html { redirect_to movie_path(@movie) }
      format.text { render "movie/show", formats: [:html] }
    end
  end

  private

  def set_movie
    @movie = Movie.includes(:media_providers).find(params[:id])
  end

  def create_similars(movie)
    @similars = movie.similar_titles_watchmode.map { |similar|
      Movie.find_by(watchmode_id: similar.to_i)
    }
    @similars.compact!
  end

  def create_recommendations(movie)
    @recommendations = movie.recommendations_tmdb.map { |reco|
      Movie.find_by(tmdb_id: reco.to_i)
    }
    @recommendations.compact!
  end
end
