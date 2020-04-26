require 'rails_helper'

feature 'User delete list' do
  scenario 'successfully', js: true do
    user =  create(:user)
    create(:list, title: 'Lista A', user: user)
    create(:list, title: 'Lista B', user: user)

    login_as(user, scoper: :user)
    visit root_path
    all(:css, '.delete')[0].click

    expect(page).not_to have_content('Lista A')
    expect(page).to have_content('Lista B')
  end
end