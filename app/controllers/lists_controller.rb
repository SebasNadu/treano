class ListsController < ApplicationController
  before_action :set_user
  before_action :set_list, only: %i[show edit update destroy]

  def index
    @lists = List.where(["public = :public", { public: true }])
  end

  def create
    @list = List.new(list_params)
    @list.user = @user
    if @list.save
      redirect_to list_path(@list)
    else
      render :lists, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @list.update(list_params)
    redirect_to list_path(@list)
  end

  def destroy
    @list.destroy
    redirect_to lists_path, status: :see_other
  end

  private

  def set_user
    @user = current_user
  end

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:list_name, :description)
  end
end
