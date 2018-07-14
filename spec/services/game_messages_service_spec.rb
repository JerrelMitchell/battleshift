require 'rails_helper'

RSpec.describe GameMessagesService do
  let(:player) { Player.new(Board.new(4)) }

  # let(:message_service) { GameMessagesService.new(player, payload: payload) }

  context 'Instance Methods' do
    describe '#ship_placement_feedback' do
      it 'should be able to return a success message along with the number of ships left for a player' do
        payload = { "ship_size" => 3,
                    "start_space" => "A1",
                    "end_space" => "A3"
                  }
        player.decrease_ship_count(payload['ship_size'])

        message_service = GameMessagesService.new(player, payload: payload)

        message = "Successfully placed ship with a size of #{payload['ship_size']}. You have #{player.ships[:cruisers]} ship(s) to place with a size of 2."

        expect(message_service.ship_placement_feedback).to eq(message)
      end

      it 'should return a different message when the player has no more ships to place' do
        player.decrease_ship_count(3)
        player.decrease_ship_count(2)

        payload = { "ship_size" => 2,
                    "start_space" => "A1",
                    "end_space" => "A3"
                  }

        message_service = GameMessagesService.new(player, payload: payload)

        message = "Successfully placed ship with a size of 2. You have 0 ship(s) to place."

        expect(message_service.ship_placement_feedback).to eq(message)
      end
    end
  end
end
