class TvsController < ApplicationController
  before_action :set_tv, only: [:show]
  skip_before_action :verify_authenticity_token, :only => [:toggle_favorite]

  def index
    @q = Tv.ransack(params[:q])
    @q.sorts = ['popularity desc'] if @q.sorts.empty?
    scope = @q.result(distinct: true).includes(:keywords, :genres, :providers)
    @pagy, @tvs = pagy(scope, items: 18)
    @keywords = []
    keywords_map = @tvs.map { |tv| tv.keywords.each { |keyword| @keywords << keyword } }
    @keywords.uniq!
    respond_to do |f|
      f.turbo_stream
      f.html
    end
  end

  def show
    create_similars(@tv)
    create_recommendations(@tv)
    @review = Review.new
    @reviewable = @tv
    @list_item = ListItem.new
    @listable = @tv
    @lists = List.where(["user_id = :user_id", { user_id: current_user.id }])
    @providers = @tv.providers
    @media_providers = @tv.media_providers
    @free_providers = @providers.where(service: "free").uniq
    @sub_providers = @providers.where(service: "sub").uniq
    @purchase_providers = @providers.where(service: "purchase").uniq
    @tve_providers = @providers.where(service: "tve").uniq
    @seasons = Season.where(tv_id: @tv)
    #raise
  end

  def toggle_favorite
    @tv = Tv.find(params[:id])
    current_user.favorited?(@tv) ? current_user.unfavorite(@tv) : current_user.favorite(@tv)
    respond_to do |format|
      format.html { redirect_to tv_path(@tv) }
      format.text { render "tv/show", formats: [:html] }
    end
  end

  private

  def set_tv
    @tv = Tv.find(params[:id])
  end

  def create_similars(tv)
    if tv.similar_titles_watchmode.present?
    @similars = tv.similar_titles_watchmode.map { |similar|
      Tv.find_by(watchmode_id: similar.to_i)
    }
    @similars.compact!
    else
      []
    end
  end

  def create_recommendations(tv)
    if tv.similar_titles_watchmode.present?
      @recommendations = tv.recommendations_tmdb.map { |reco|
        Tv.find_by(tmdb_id: reco.to_i)
      }
      @recommendations.compact!
    else
      []
    end
  end
end
