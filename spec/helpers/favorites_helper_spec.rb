require 'rails_helper'

describe FavoritesHelper do
  describe '#change_star' do
    it 'returns fullfiled icon star when user dont have favorite' do
      user = create(:user)
      user_list = create(:user, email: 'userlist@example.com')
      list = create(:list, user: user_list)

      result = helper.change_star(list, user)

      expect(result).to eq('far')
    end

    it 'return unfiled icon star when user had already favorited' do
      user = create(:user)
      create(:favorite, user: user)
      user_list = create(:user, email: 'userlist@example.com')
      list = create(:list, user: user_list)
      user.favorite.lists << list

      result = helper.change_star(list, user)

      expect(result).to eq('fas')
    end

    it 'return fullfiled icon star when user click in a unfavorite' do
      user = create(:user)
      create(:favorite, user: user)
      user_list = create(:user, email: 'userlist@example.com')
      list = create(:list, user: user_list)

      result = helper.change_star(list, user)

      expect(result).to eq('far')
    end
  end
end