class HomeController < ApplicationController  
  def index
      @lists = current_user.lists.order(:created_at) if user_signed_in?
  end
end