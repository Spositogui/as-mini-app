require 'rails_helper'

feature 'User sees the main page' do
  scenario 'successfully' do
    visit root_path

    expect(page).to have_content("Bem vindo(a) ao\nAS-MiniApp")
    expect(page).to have_link('Entrar')
    expect(page).not_to have_link('Sair')
  end
end