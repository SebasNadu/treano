class ListItemsController < ApplicationController
  before_action :set_listable

  def create
    @list_item = ListItem.new(list_item_params)
    @list = List.find(params[:list_item][:list_id])
    @list_item.list = @list
    @list_item.listable = @listable
    if @list_item.save
      redirect_to movie_path(Movie.find(params[:movie_id]))
    else
      @list_item = ListItem.new
      render "movies/show", status: :unprocessable_entity
    end
  end

  private

  def set_listable
    if params[:movie_id].present?
      @listable = Movie.find(params[:movie_id])
    elsif params[:tv_id].present?
      @listable = Tv.find(params[:tv_id])
    end
  end

  def list_item_params
    params.require(:list_item).permit(:listable_id, :listable_type)
  end
end
