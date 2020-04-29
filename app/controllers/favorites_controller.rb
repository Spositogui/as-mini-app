class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    return nil if current_user.favorite.nil?
    @favorites = current_user.favorite.lists
  end

  def delete_favorited_list
    current_user.favorite.lists.delete(List.find(params[:list_id]))
    render 'delete_favorited_list.js.erb'
  end

  def favorite
    list = List.find(params[:list_id])
    current_user.favorite ||= Favorite.create(user_id: current_user.id)
    favorited?(list)
    @public_lists = List.public_lists(current_user.id)
    render 'favorite.js.erb'
  end

  private

    def favorited?(list)
      user = current_user
      return user.favorite.lists << list if user.favorite.lists.blank?
      return user.favorite.lists.delete(list) if user.favorite.lists
                                                              .exists?(list.id)

      user.favorite.lists << list
    end
end