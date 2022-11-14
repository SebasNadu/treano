class TvsController < ApplicationController
  before_action :set_tv, only: [:show]
  def index
    @tvs = Tv.all
  end

  def show
  end

  private

  def set_tv
    @tv = Tv.find(params[:id])
  end
end
