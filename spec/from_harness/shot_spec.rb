require 'rails_helper'
require_relative 'support/spec_helper'

RSpec.describe "Game Shots" do
  context "POST /api/v1/games/1/shots" do
    it "protects against invalid API keys" do
      # BEGIN this will not work in the spec_harness
      User.create!(name: 'Sally', email: 's@example.com', password: 'password', status: 1)
      User.create!(name: 'Atticus', email: 'finch@example.com', password: 'mockingbird', status: 1)

      player_type = "challenger"
      player_1_board = Board.new(4)
      player_2_board = Board.new(4)
      game_attributes = {
                      player_1_board: player_1_board,
                      player_2_board: player_2_board,
                      player_1_turns: 0,
                      player_2_turns: 0,
                      current_turn: player_type
                    }

      game = Game.create!(game_attributes)
      # END
      # game = create_game
      endpoint = "/api/v1/games/#{game.id}/shots"
      payload = {target: "B1"}.to_json

      response = post_json(endpoint, payload, "NotARealAPIKey")
      expect(response.status).to eq(401)
      expect(response.body[:message]).to eq("Unauthorized")
    end

    xit "prevents a player from playing a game they are not part of" do
      # Write tests within your app to accomplish this.
      # This is just a friendly reminder.
    end
  end
end
