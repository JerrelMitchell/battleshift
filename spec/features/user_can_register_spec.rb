require 'rails_helper'

RSpec.describe 'User Registration' do
  it 'they should be able to reach the registration page' do
    visit '/'

    click_link 'Register'

    expect(page).to have_current_path('/register')
  end
end
