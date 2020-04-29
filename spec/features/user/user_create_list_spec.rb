require 'rails_helper'

feature 'User create list' do
  before(:each) do
    user = create(:user)
    login_as(user, scope: :user)
  end

  context 'list only' do
    scenario 'successfully', js: true do
      visit root_path
      click_on 'Nova lista'
      fill_in 'Titulo', with: 'Lista de estudos'
      fill_in 'Descrição', with: 'Veniam mollit dolore magna nisi ex dolore.'
      page.choose('Publica')#radio btn
      click_on 'Criar lista'

      expect(page).to have_content('Lista de estudos')
      expect(page).to have_content('Estado: Publica')
      expect(List.count).to eq(1)
    end

    scenario "and at least title can't be blank", js: true do
      visit root_path
      click_on 'Nova lista'
      click_on 'Criar lista'

      expect(page).to have_content("Title can't be blank")
    end
  end

  context  'list with tasks' do
    scenario 'successfully', js: true do
      visit root_path
      click_on 'Nova lista'
      fill_in 'Titulo', with: 'Lista A'
      click_on 'Adicionar tarefa'
      fill_in 'Name', with: 'Primeira tarefa'
      click_on 'Criar lista'

      expect(page).to have_content('Lista A')
      expect(Task.count).to eq(1) 
    end

    scenario 'and add multiple fields', js: true do
      visit root_path
      click_on 'Nova lista'
      fill_in 'Titulo', with: 'Games'
      click_on 'Adicionar tarefa'
      click_on 'Adicionar tarefa'
      all(:css, 'tr.task-row')[0].fill_in 'Name', with: 'DS3'
      all(:css, 'tr.task-row')[1].fill_in 'Name', with: 'Valorant'
      click_on 'Criar lista'

      expect(Task.count).to eq(2)
      expect(page).to have_content('Games')
    end

    scenario 'and task without a name will not be saved', js: true do
      visit root_path
      click_on 'Nova lista'
      fill_in 'Titulo', with: 'Games'
      click_on 'Adicionar tarefa'
      fill_in 'Name', with: ''
      click_on 'Criar lista'

      expect(Task.count).to eq(0)
    end

    scenario 'and can delete task field', js: true do
      visit root_path
      click_on 'Nova lista'
      fill_in 'Titulo', with: 'Games'
      click_on 'Adicionar tarefa'
      find(:css, '.remove-task-field').set(true)

      expect(page).not_to have_css('tr.task-row')
    end
  end
end