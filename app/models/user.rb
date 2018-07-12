class User < ApplicationRecord
  validates_presence_of :name, :email, :password_digest
  validates_uniqueness_of :email
  validates_confirmation_of :password

  has_many :user_games
  has_many :games, through: :user_games

  has_secure_password
  has_secure_token :auth_token
  has_secure_token :activation_token

  enum status: [:inactive, :active]

  def activated?
    status == 'active'
  end
end
