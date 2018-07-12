require 'rails_helper'

RSpec.describe UserGame do
  describe 'Relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:game) }
  end
end
