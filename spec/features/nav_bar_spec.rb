require 'rails_helper'

RSpec.describe 'Navigation Bars' do
  describe 'Non-logged in user visiting' do
    it 'home page should have navigation bar links' do
      visit '/'

      expect(page).to have_css('#navigation')
      expect(page).to have_link('Dashboard')
      expect(page).to have_link('Login')
    end
  end

  describe 'Logged in user' do
    it 'home page should have navigation bars' do
      user = User.create!(name: 'Sally', email: 'sally@example.com', password: 'sallyspassword', status: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/'

      expect(page).to have_css('#navigation')
      expect(page).to have_link('Dashboard')
      expect(page).to have_link('Logout')
    end

    it 'dashboard page should have navigation bars' do
      user = User.create!(name: 'Sally', email: 'sally@example.com', password: 'sallyspassword', status: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      expect(page).to have_css('#navigation')
      expect(page).to have_link('Dashboard')
      expect(page).to have_link('Logout')
    end
  end
end
