require 'rails_helper'

describe Task do
  context  'Task' do
    it 'successfully created' do
      user = create(:user)
      list = create(:list, user: user)

      Task.create(name: 'Fazer dever de casa', list: list)

      expect(Task.count).to  eq(1)
      expect(list.tasks.first.name).to  eq('Fazer dever de casa')
    end

    it 'and list must exist' do
      result = Task.create(name: 'Task A')

      expect(result.errors.full_messages).to include('List must exist')
    end
  end
end
