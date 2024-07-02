require 'rails_helper'

RSpec.describe 'User', type: :system do
  describe 'method' do
    let!(:user) { create(:user) }

    it 'returns the name' do
      expect(user.name).to match 'User'
    end
  end
end
