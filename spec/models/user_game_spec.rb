require 'rails_helper'

RSpec.describe UserGame do
  describe 'Relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:game) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:player) }
  end
end
