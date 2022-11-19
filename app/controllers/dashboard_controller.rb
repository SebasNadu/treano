class DashboardController < ApplicationController
  def index
    @user = current_user
    @list = List.new
    @lists = List.where(["user_id = :user_id", { user_id: @user }])
  end

  def show
    @user
  end
end
