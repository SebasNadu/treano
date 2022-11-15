class DashboardController < ApplicationController
  before_action :set_user

  def dashboard
    @list = List.new
    @lists = List.where(["user_id = :user_id", { user_id: @user }])
  end

  private

  def set_user
    @user = current_user
  end
end
