class SavedListsController < ApplicationController
  before_action :set_list
  
  def create
    @saved_list = SavedList.new(saved_list_params)
    @saved_list.list = @list
    @saved_list.user = current_user
    respond_to do |format|
      if @saved_list.save
        @list.user.reputation_score += 5
        @list.user.save
        format.html { redirect_to :back }
        format.text { render partial: "lists/list", locals: { list: @list }, formats: [:html] }
      else
        format.html { redirect_to :back, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def saved_list_params
    params.require(:saved_list).permit(:list)
  end
end
