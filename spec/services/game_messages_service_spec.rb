require 'rails_helper'

RSpec.describe GameMessagesService do
  let(:player) { Player.new(Board.new(4)) }
  let(:game) { 
    Game.create( player_1_board: Board.new(4),
              player_2_board: Board.new(4),
              player_1_turns: 0,
              player_2_turns: 0,
              current_turn: "challenger"
    ) 
  }

  # let(:message_service) { GameMessagesService.new(player, payload: payload) }

  context 'Instance Methods' do
    describe '#ship_placement_feedback' do
      it 'should be able to return a success message along with the number of ships left for a player' do
        payload = { "ship_size" => 3,
                    "start_space" => "A1",
                    "end_space" => "A3"
                  }
        ship = Ship.new(payload['ship_size'])
        game.update(player_1_destroyer_count: game.player_1_destroyer_count - 1)

        message_service = GameMessagesService.new(game: game, ship: ship, player_number_string: 'player_1')

        message = "Successfully placed ship with a size of #{payload['ship_size']}. You have #{player.ships[:cruisers]} ship(s) to place with a size of 2."

        expect(message_service.ship_placement_feedback).to eq(message)
      end

      it 'should return a different message when the player has no more ships to place' do
        game.update(player_1_destroyer_count: game.player_1_destroyer_count - 1)
        game.update(player_1_cruiser_count: game.player_1_cruiser_count - 1)
        
        payload = { "ship_size" => 2,
          "start_space" => "A1",
          "end_space" => "A3"
        }
        ship = Ship.new(payload['ship_size'])

        message_service = GameMessagesService.new(game: game, ship: ship, player_number_string: 'player_1')

        message = "Successfully placed ship with a size of 2. You have 0 ship(s) to place."

        expect(message_service.ship_placement_feedback).to eq(message)
      end
    end
  end
end
