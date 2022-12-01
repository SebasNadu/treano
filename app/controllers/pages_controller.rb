require "json"

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]
  before_action :set_parses, only: %i[home]
  before_action :set_user, only: %i[dashboard my_lists]

  def home
    @lists = List.where(["user_id = :user_id", { user_id: current_user }])
    @airly_tvs = set_tvs(@t_airly_tvs)
    @popular_tvs = set_tvs(@t_popular_tvs)
    @toprated_tvs = set_tvs(@t_toprated_tvs)
    @weeklytrends_tvs = set_tvs(@t_weeklytrends_tvs)
    @popular_movies = set_movies(@t_popular_movies)
    @toprated_movies = set_movies(@t_toprated_movies)
    @weeklytrends_movies = set_movies(@t_weeklytrends_movies)
    @upcoming_movies = set_movies(@t_upcoming_movies)
    @trends_media = []
    10.times do |i|
      @trends_media << @weeklytrends_movies[i]
      @trends_media << @weeklytrends_tvs[i]
      i += 1
    end
  end

  def dashboard
    @reviews = Review.where(["user_id = :user_id", { user_id: @user }])
    @new_list = List.new
    @lists = List.where(["user_id = :user_id", { user_id: @user }])
    #raise
  end

  def my_lists
    @lists = List.where(["user_id = :user_id", { user_id: @user }])
  end

  def search
    if params[:q]
      if params[:q]["movies"]
        @q = Movie.ransack(params[:q])
        @q.sorts = ['rating_average desc', 'critic_score desc', 'popularity desc'] if @q.sorts.empty?
        @movies = @q.result(distinct: true)
        @keywords = []
        keywords_map = @movies.map { |movie| movie.keywords.each { |keyword| @keywords << keyword } }
        @keywords.uniq!
      elsif params[:q][:tvs]
        @q = Tv.ransack(params[:q])
        @q.sorts = ['rating_average desc', 'critic_score desc', 'popularity desc'] if @q.sorts.empty?
        @tvs = @q.result(distinct: true)
        @keywords = []
        keywords_map = @tvs.map { |movie| movie.keywords.each { |keyword| @keywords << keyword } }
        @keywords.uniq!
      elsif params[:q][:lists]
        @q = List.where(["public = :public", { public: true }]).ransack(params[:q])
        @q.sorts = ['votes desc'] if @q.sorts.empty?
        @lists = @q.result(distinct: true)
      end
    end
    #raise
  end

  def profile
    if params[:user_id].present?
      @user = User.find(params[:user_id])
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_movies(movies)
    movies.map do |movie|
      movie = {
        title: movie["title"],
        overview: movie["overview"],
        poster_url: "https://image.tmdb.org/t/p/w342#{movie["poster_path"]}",
        backdrop_url: "https://image.tmdb.org/t/p/w1280#{movie["backdrop_path"]}",
        rating_average: movie["vote_average"],
        tmdb_id: movie["id"],
        release_date: movie["release_date"],
        homepage: "",
        trailer: "",
        tagline: "",
        runtime: "",
        budget: "",
        revenue: "",
        status: "",
        original_language: "",
        year: "",
        critic_score: "",
        popularity: "",
        genre_names: "",
        similar_titles_watchmode: [],
        recommendations_tmdb: [],
        us_rating: "",
        watchmode_id: "",
        imdb_id: ""
      }
    end
  end

  def set_tvs(tvs)
    tvs.map do |tv|
      tv = {
        title: tv["name"],
        overview: tv["overview"],
        poster_url: "https://image.tmdb.org/t/p/w342#{tv["poster_path"]}",
        backdrop_url: "https://image.tmdb.org/t/p/w1280#{tv["backdrop_path"]}",
        rating_average: tv["vote_average"],
        tmdb_id: tv["id"],
        country: tv["origin_country"],
        first_air_date: tv["first_air_date"]
      }
    end
  end

  def set_parses
    @t_airly_tvs = JSON.parse(File.read("t_ontheair_tvs.json"))["results"]
    @t_popular_tvs = JSON.parse(File.read("t_popular_tvs.json"))["results"]
    @t_toprated_tvs = JSON.parse(File.read("t_toprated_tvs.json"))["results"]
    @t_weeklytrends_tvs = JSON.parse(File.read("t_weeklytrends_tvs.json"))["results"]
    @t_popular_movies = JSON.parse(File.read("t_popular_movies.json"))["results"]
    @t_toprated_movies = JSON.parse(File.read("t_toprated_movies.json"))["results"]
    @t_weeklytrends_movies = JSON.parse(File.read("t_weeklytrends_movies.json"))["results"]
    @t_upcoming_movies = JSON.parse(File.read("t_upcoming_movies.json"))["results"]
  end

end
