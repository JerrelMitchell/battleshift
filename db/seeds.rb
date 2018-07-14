player_1_board = Board.new(4)
player_2_board = Board.new(4)

sm_ship = Ship.new(2)
md_ship = Ship.new(3)

# Place Player 1 ships
ShipPlacer.new(board: player_1_board,
               ship: sm_ship,
               start_space: "A1",
               end_space: "A2").run

ShipPlacer.new(board: player_1_board,
               ship: md_ship,
               start_space: "B1",
               end_space: "D1").run

# Place Player 2 ships
ShipPlacer.new(board: player_2_board,
               ship: sm_ship.dup,
               start_space: "A1",
               end_space: "A2").run

ShipPlacer.new(board: player_2_board,
               ship: md_ship.dup,
               start_space: "B1",
               end_space: "D1").run

game_attributes = {
  player_1_board: player_1_board,
  player_2_board: player_2_board,
  player_1_turns: 0,
  player_2_turns: 0,
  current_turn: "challenger"
}

game = Game.new(game_attributes)
game.save!

User.create(name: "Bluth", email: "example@example.com", password: "123abc", status: 1, auth_token: "dEJS3d9m3RKSGKmoNYnGSPx5")
User.create(name: "Job", email: "notanemail@example.com", password: "123abc", status: 1, auth_token: "e9TceAxUHYzny3rV7K5rfAmx")
