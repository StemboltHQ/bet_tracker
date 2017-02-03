class BetOption < ApplicationRecord
  has_many :users, through: :user_bets
  has_many :user_bets
end
