class ListsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @list = List.new
    respond_to :js
  end

  def edit
    @list = List.find(params[:id])
    respond_to :js
  end

  def create
    @list = List.new(list_params)
    @list.user_id = current_user.id
    if @list.save
      @lists = current_user.lists.order(:created_at)
      respond_to :js
    else
      render 'shared/errors.js.erb'
    end
  end

  def update
    @list = List.find(params[:id])
    if @list.update(list_params)
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

  def see_entire_list
    @list = List.find(params[:list_id])
    render 'entire_list.js.erb'
  end

  private 
    
    def list_params
      params.require(:list).permit(:title, :description, :status, 
                                   tasks_attributes: [:id, :name, :_destroy])
    end
end