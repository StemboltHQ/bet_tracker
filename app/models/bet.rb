class Bet < ApplicationRecord
  has_many :users, through: :user_bets
  has_many :user_bets
  has_many :options, through: :user_bets, source: :bet_option
end
