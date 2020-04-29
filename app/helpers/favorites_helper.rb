module FavoritesHelper
  def change_star(list, user)
    return 'far' if user.favorite.blank?
    return 'fas' if user.favorite.lists.exists?(list.id)
    'far'
  end
end