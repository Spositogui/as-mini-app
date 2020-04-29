require 'rails_helper'

describe Favorite do
  describe 'Favorite' do
    it 'successfully created' do
      user = create(:user)

      result = Favorite.create(user_id: user.id)

      expect(Favorite.count).to eq(1)
      expect(result.user).to eq(user)  
    end

    it 'user must exist' do
      result = Favorite.create

      expect(Favorite.count).to eq(0)
      expect(result.errors.full_messages).to include('User must exist')  
    end
  end
end
