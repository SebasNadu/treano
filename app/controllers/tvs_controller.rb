class TvsController < ApplicationController
  before_action :set_tv, only: [:show]
  def index
    @tvs = Tv.all
  end

  def show
    @review = Review.new
    @reviewable = @tv
    @list_item = ListItem.new
    @listable = @tv
    @lists = List.where(["user_id = :user_id", { user_id: current_user.id }])
  end

  private

  def set_tv
    @tv = Tv.find(params[:id])
  end
end
