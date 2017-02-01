class User < ApplicationRecord
  has_many :bets, through: :outcome
  has_many :outcome

  has_secure_password
end
