require 'rails_helper'

feature 'User sign up' do
  scenario 'successfully' do
    visit root_path
    click_on 'Entrar'
    click_on 'Cadastrar'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirme a senha', with: '123456'
    click_on 'Criar'

    expect(page).to have_content('Welcome! You have signed up successfully.')
  end

  scenario 'and all fields must be fill in' do
    visit root_path
    click_on 'Entrar'
    click_on 'Cadastrar'
    click_on 'Criar'

    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
  end
end