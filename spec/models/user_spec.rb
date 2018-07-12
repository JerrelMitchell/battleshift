require 'rails_helper'

RSpec.describe User do
  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
    it { should have_secure_password }
  end

  describe 'Relationships' do
    it { should have_many(:user_games) }
    it { should have_many(:games).through(:user_games) }
  end

  describe 'activation' do
    it 'verifies account has been activated' do
      user = User.create!(name: 'Sally Test', email: 'sally@example.com', password: 'sallyspassword', status: 1)

      expect(user.activated?).to be_truthy
    end
    it 'verifies account has not been activated' do
      user = User.create!(name: 'Sally Test', email: 'sally@example.com', password: 'sallyspassword', status: 0)

      expect(user.activated?).to_not be_truthy
    end
  end
end
