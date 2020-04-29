class FavoritesController < ApplicationController
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