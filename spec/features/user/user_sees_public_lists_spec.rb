require 'rails_helper'

feature 'User sees other users public lists' do
  scenario 'successfully' do
    user_a = create(:user)
    user_b = create(:user, email: 'userb@example.com')
    create(:list, title: 'Lista A', status: :publica, user: user_a)
    create(:list, title: 'Lista B', status: :publica, user: user_b)
    create(:list, title: 'Lista C', status: :privada, user: user_b)

    login_as(user_a, scope: :user)
    visit root_path
    click_on 'Listas públicas'

    expect(page).to have_content('Lista B')
    expect(page).not_to have_content('Lista A')
    expect(page).not_to have_content('Lista C')
  end

  scenario 'and not have any public list' do
    user = create(:user)

    login_as(user, scope: :user)
    visit public_lists_path

    expect(page).to have_content('Não existem listas públicas no momento.')
  end

  scenario 'and must be logged' do
    visit public_lists_path

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content('You need to sign in or sign up before'\
                                 ' continuing.')
  end
end