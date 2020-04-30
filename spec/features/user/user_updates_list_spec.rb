require 'rails_helper'

feature 'User update list and task' do
  scenario 'successfully', js: true do
    user = create(:user)
    list =  create(:list, title: 'Games', user_id: user.id)
    create(:task, name: 'R6', list: list)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Games'
    fill_in 'Titulo', with: 'Meus games'
    choose('Publica')
    fill_in 'Name', with: 'Tom Clancy'
    click_on 'Adicionar tarefa'
    all(:css, 'tr.task-row')[1].fill_in 'Name', with: 'Zelda'
    click_on 'Salvar mudanças'

    expect(page).to have_content('Meus games')
    expect(Task.count).to eq(2)
    expect(Task.first.name).to eq('Tom Clancy')
    expect(Task.second.name).to eq('Zelda')
  end

  scenario 'and can exclude one task', js: true do
    user = create(:user)
    list =  create(:list, title: 'Games', user_id: user.id)
    create(:task, name: 'R6', list: list)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Games'
    find(:css, '.remove-task-field').click
    click_on 'Salvar mudanças'

    expect(Task.count).to eq(0)
  end
end