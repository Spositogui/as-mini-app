require 'rails_helper'

describe List do
  describe 'List' do
    it 'successfully created' do
      user = create(:user)

      result = List.create(title: 'Lista 1', description: 'Anim quis non.', 
                          status: :privada, user_id: user.id)

      expect(List.count).to eq(1)
      expect(result.title).to eq('Lista 1')
      expect(result.description).to eq('Anim quis non.')
      expect(result.status).to eq('privada')
    end

    it 'title must exists' do
      user = create(:user)

      result = List.create(title: '', description: 'Anim quis non.', 
                          status: :privada, user_id: user.id)

      expect(List.count).to eq(0)
      expect(result.errors.full_messages).to include("Title can't be blank")
    end

    it 'user must exists' do
      result = List.create(title: 'Lista', description: 'Anim quis non.', 
                           status: :privada)

      expect(List.count).to eq(0)
      expect(result.errors.full_messages).to include("User must exist")
    end

    it 'created with task' do
      user = create(:user)
      list = create(:list, title: 'Games', user_id: user.id)
      create(:task, name: 'Brain', list: list)

      expect(list.tasks.count).to eq(1)
    end
  end

  describe '.public_lists' do
    it 'return all public lists' do
      user = create(:user)
      user_t = create(:user, email: 'user2@example.com')
      create(:list, title: 'Games', status: :publica, user_id: user.id)
      create(:list, title: 'Compras', status: :publica, user_id: user.id)
      create(:list, title: 'Estudos', status: :publica, user_id: user.id)

      result = List.public_lists(user_t)

      expect(result.count).to eq(3)
      expect(result[0].title).to eq('Games')
      expect(result[1].title).to eq('Compras')
      expect(result[2].title).to eq('Estudos')
    end

    it 'should not return the owner lists' do
      user = create(:user)
      user2 = create(:user, email: 'user2@example.com')
      create(:list, title: 'Games', status: :publica, user_id: user.id)
      create(:list, title: 'Compras', status: :publica, user_id: user2.id)

      result = List.public_lists(user)

      expect(result.count).to eq(1)
      expect(result[0].title).to eq('Compras')
    end

    it 'should not return private lists' do
      user = create(:user)
      user2 = create(:user, email: 'user2@example.com')
      create(:list, title: 'Games', status: :publica, user_id: user2.id)
      create(:list, title: 'Compras', status: :privada, user_id: user2.id)

      result = List.public_lists(user)

      expect(result.count).to eq(1)
      expect(result[0].title).to eq('Games')
    end

    it 'must return blank if not exist lists' do
      user = create(:user)

      result = List.public_lists(user)

      expect(result.count).to eq(0)
      expect(result).to be_blank
    end
  end
end
