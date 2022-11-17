class ListItemsController < ApplicationController
  before_action :set_listable

  def create
    @list_item = ListItem.new(list_item_params)
    @list = List.find(params[:list_item][:list_id])
    @list_item.list = @list
    @list_item.listable = @listable
    if @list_item.save
      redirect_to polymorphic_path(@listable)
    else
      @list_item = ListItem.new
      @movie = Movie.find(params[:movie_id])
      render 'movies/show', status: :unprocessable_entity
      raise
    end
  end

  def destroy
    @list_item = ListItem.find(params[:id])
    @list_item.destroy
    redirect_to polymorphic_path(@list_item.list), status: :see_other
  end

  private

  def set_listable
    if params[:movie_id].present?
      @listable = Movie.find(params[:movie_id])
    else
      @listable = Movie.find(params[:id])
    end
  end

  # def set_listable
  #   if params[:movie_id].present?
  #     @listable = Movie.find(params[:movie_id])
  #   elsif params[:tv_id].present?
  #     @listable = Tv.find(params[:tv_id])
  #   end
  # end

  def list_item_params
    params.require(:list_item).permit(:listable_id, :listable_type)
  end
end
