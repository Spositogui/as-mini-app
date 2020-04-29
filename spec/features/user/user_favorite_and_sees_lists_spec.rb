require 'rails_helper'

feature 'User favorit lists and sees favorited lists' do
  context 'favorite lists' do
    scenario 'successfully', js: true do
      user = create(:user)
      user_b = create(:user, email: 'userb@example.com')
      create(:list, title: 'Lista do Usuario B', status: :publica, user: user_b)

      login_as(user, scope: :user)
      visit root_path
      click_on 'Listas públicas'
      find(:css, '.btn.favorite').click

      expect(user.favorite.lists.count).to eq(1)
    end

    scenario 'and with multiple lists saved' do
      user = create(:user)
      create(:favorite, user: user)
      user_b = create(:user, email: 'userb@example.com')
      l1 = create(:list, title: 'Lista do Usuario B', status: :publica, user: user_b)
      create(:list, title: 'Outra Lista', status: :publica, user: user_b)
      user.favorite.lists << l1

      login_as(user, scope: :user)
      visit public_lists_path
      all(:css, '.btn.favorite')[1].click

      expect(user.favorite.lists.count).to eq(2)
    end

    scenario 'unfavorite a list' do
      user = create(:user)
      create(:favorite, user: user)
      user_b = create(:user, email: 'userb@example.com')
      l1 = create(:list, title: 'Lista do Usuario B', status: :publica, user: user_b)
      user.favorite.lists << l1

      login_as(user, scope: :user)
      visit public_lists_path
      find(:css, '.btn.favorite').click

      expect(user.favorite.lists.count).to eq(0)
    end
  end
end