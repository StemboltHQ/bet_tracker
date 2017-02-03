class User < ApplicationRecord
  has_many :bets, through: :user_bets
  has_many :user_bets
end
