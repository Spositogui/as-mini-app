class ListsController < ApplicationController
  def new
    @list = List.new
    respond_to :js
  end

  def create
    @list = List.new(params.require(:list).permit(:title, :description, :status)
                                          .merge(user_id: current_user.id))
    if @list.save
      @lists = current_user.lists.order(:created_at)
      respond_to :js
    end
  end
end