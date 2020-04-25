require 'rails_helper'

feature 'User does login' do
  scenario 'successfully' do
    user = create(:user, email: 'user@example.com', password: '123456')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email 
    fill_in 'Senha', with: user.password
    click_on 'Confirmar'

    expect(page).to have_content('Listas públicas')
    expect(page).to have_content('Favoritadas')
    expect(page).to have_content('user@example.com')
    expect(page).to have_content('Sair')
    expect(page).to have_link('Nova lista')
    expect(page).not_to have_content('Entrar')
    expect(page).not_to have_content("Bem vindo(a) ao\nAS-MiniApp")
  end

  scenario 'email and password cant be blank' do
    visit root_path
    click_on 'Entrar'
    click_on 'Confirmar'

    expect(page).to have_content('Invalid Email or password.')
  end
end