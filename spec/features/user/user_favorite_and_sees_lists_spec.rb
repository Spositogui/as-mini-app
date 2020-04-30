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
  
  context 'see favorited lists' do
    scenario 'successfully' do
      user = create(:user)
      create(:favorite, user_id: user.id)
      user2 = create(:user, email: 'user2@example.com')
      list = create(:list, title: 'Games', status: :publica, user_id: user2.id)
      user.favorite.lists << list

      login_as(user, scope: :user)
      visit root_path
      click_on 'Favoritadas'

      expect(page).to have_content('Games')  
    end

    scenario 'and see entire list', js: true do
      user = create(:user)
      create(:favorite, user_id: user.id)
      user2 = create(:user, email: 'user2@example.com')
      list = create(:list, title: 'Games', status: :publica, user_id: user2.id)
      create(:task, name: 'Valorant', list: list)
      user.favorite.lists << list

      login_as(user, scope: :user)
      visit favorites_path
      click_on 'Games'

      expect(page).to have_selector("input[value='Games']")
      expect(page).to have_selector("input[value='Valorant']") 
    end

    scenario 'and not have any favorited list' do
      user = create(:user)
      
      login_as(user, scope: :user)
      visit favorites_path

      expect(page).to have_content('Você não tem nenhuma lista favorita.')
    end

    scenario 'and must be logged' do
      visit favorites_path 

      expect(current_path).to eq(new_user_session_path)
      expect(page).to have_content('You need to sign in or sign up before'\
                                   ' continuing.')
    end

    scenario 'and exclude favorited list' do
      user = create(:user)
      create(:favorite, user_id: user.id)
      user2 = create(:user, email: 'user2@example.com')
      list = create(:list, title: 'Games', status: :publica, user_id: user2.id)
      user.favorite.lists << list

      login_as(user, scope: :user)
      visit favorites_path
      click_on 'Deletar'

      expect(user.favorite.lists.count).to eq(0)
      expect(page).not_to have_content('Games')
      expect(page).not_to have_content('user2@example.com')
    end
  end
end