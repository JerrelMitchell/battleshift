require 'rails_helper'

RSpec.describe Player do
  let(:player) { Player.new(Board.new(4))}
  describe 'Attributes' do
    it 'should be created with a board' do
      expect(player.board).to be_a Board
    end

    it 'should be created with 1 destroyer and 1 cruiser' do
      expect(player.ships[:destroyers]).to eq(1)
      expect(player.ships[:cruisers]).to eq(1)
    end
  end

  describe 'Instance Methods' do
    describe '#decrease_ship_count' do
      it 'should decrease the given ship amount by 1' do
        player.decrease_ship_count(:destroyers)

        expect(player.ships[:destroyers]).to eq(0)
      end
    end
  end
end
