class User < ApplicationRecord
  validates_presence_of :name, :email, :password_digest
  validates_uniqueness_of :email
  validates_confirmation_of :password

  has_secure_password
  has_secure_token :auth_token

  enum status: [:inactive, :active]

  def activated?
    status == 'active'
  end
end
