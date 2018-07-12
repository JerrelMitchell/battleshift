class UserGame < ApplicationRecord
  validates_presence_of :player

  belongs_to :user
  belongs_to :game

  enum player: ['player_1', 'player_2']
end
