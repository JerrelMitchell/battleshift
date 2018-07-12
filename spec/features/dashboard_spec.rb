require 'rails_helper'

RSpec.describe 'Dashboard Page' do
  it 'should redirect guests to the login page' do
    visit '/dashboard'

    expect(page).to have_current_path('/login')
  end
end
