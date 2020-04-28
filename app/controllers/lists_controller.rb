class ListsController < ApplicationController
  before_action :authenticate_user!
  
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
    else
      render 'shared/errors.js.erb'
    end
  end

  def destroy
    List.find(params[:id]).destroy
    respond_to :js
  end

  def public_lists
    @public_lists = List.public_lists(current_user.id)
  end
end