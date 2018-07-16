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

        message_service = GameMessagesService.new(game: game, ship: ship)

        message = "Successfully placed ship with a size of #{payload['ship_size']}. You have #{player.ships_to_place[:cruisers]} ship(s) to place with a size of 2."

        expect(message_service.ship_placement_feedback).to eq(message)
      end

      it 'should be able to return a success message along with the number of ships and ship size left for a player' do
        payload = { "ship_size" => 2,
                    "start_space" => "A1",
                    "end_space" => "A2"
                  }
        ship = Ship.new(payload['ship_size'])
        game.update(player_1_cruiser_count: game.player_1_cruiser_count - 1)

        message_service = GameMessagesService.new(game: game, ship: ship)

        message = "Successfully placed ship with a size of #{payload['ship_size']}. You have #{player.ships[:destroyers]} ship(s) to place with a size of 3."

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

        message_service = GameMessagesService.new(game: game, ship: ship)

        message = "Successfully placed ship with a size of 2. You have 0 ship(s) to place."

        expect(message_service.ship_placement_feedback).to eq(message)
      end

      it 'should return a same message when the player 2 has no more ships to place' do
        game.update(player_2_destroyer_count: game.player_1_destroyer_count - 1)
        game.update(player_2_cruiser_count: game.player_1_cruiser_count - 1)

        payload = { "ship_size" => 2,
          "start_space" => "A1",
          "end_space" => "A3"
        }
        ship = Ship.new(payload['ship_size'])

        message_service = GameMessagesService.new(game: game, ship: ship)

        message = "Successfully placed ship with a size of 2. You have 0 ship(s) to place."
        game.current_turn = 'opponent'

        expect(message_service.ship_placement_feedback).to eq(message)
      end
    end

    describe '#not_your_turn' do
      it 'should return a message about it not being that players turn' do
        expect(GameMessagesService.new.not_your_turn).to eq('Invalid move. It\'s your opponent\'s turn')
      end
    end

    describe '#invalid_coordinates' do
      it 'should return an invalid coordinates message' do
        expect(GameMessagesService.new.invalid_coordinates).to eq('Invalid coordinates.')
      end
    end

    describe '#game_over' do
      it 'should return a game over message' do
        expect(GameMessagesService.new.game_over).to eq('Invalid move. Game over.')
      end
    end
  end
end
