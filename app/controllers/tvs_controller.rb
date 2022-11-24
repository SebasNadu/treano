class TvsController < ApplicationController
  before_action :set_tv, only: [:show]

  def index
    @tvs = Tv.all
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
  end

  private

  def set_tv
    @tv = Tv.find(params[:id])
  end

  def create_similars(tv)
    @similars = tv.similar_titles_watchmode.map { |similar|
      Tv.find_by(watchmode_id: similar.to_i)  
    }
    @similars.compact!
  end

  def create_recommendations(tv)
    @recommendations = tv.recommendations_tmdb.map { |reco|
      Tv.find_by(tmdb_id: reco.to_i)  
    }
    @recommendations.compact!
  end
end
