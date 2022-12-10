class ListsController < ApplicationController
  before_action :set_user
  before_action :set_list, only: %i[show edit update destroy]

  def index
    #@lists = List.where(["public = :public", { public: true }])
    @q = List.where(["public = :public", { public: true }]).ransack(params[:q])
    @q.sorts = ['votes desc'] if @q.sorts.empty?
    scope = @q.result(distinct: true).includes(:user)
    @pagy, @lists = pagy(scope, items: 24)
    respond_to do |f|
      f.turbo_stream
      f.html
    end
  end

  def create
    @list = List.new(list_params)
    @list.user = @user
    if @list.save
      @list.save
      redirect_to user_my_lists_path(current_user)
    else
      render 'pages/my_lists', status: :unprocessable_entity
    end
  end

  def show
    #raise
  end

  def edit
  end

  def update
    @list.update(list_params)
    redirect_to list_path(@list)
  end

  def destroy
    @list.destroy
    redirect_to user_my_lists_path(current_user), status: :see_other
  end

  def toggle_favorite
    @list = List.find(params[:id])
    current_user.favorited?(@list) ? current_user.unfavorite(@list) : current_user.favorite(@list)
    respond_to do |format|
      format.html { redirect_back_or_to user_my_lists_path(current_user) }
      format.text { render partial: "lists/list", formats: [:html] }
    end
  end

  def untoggle
  end

  private

  def set_user
    @user = current_user
  end

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:list_name, :description, :public, :cover_picture, :votes)
  end
end
