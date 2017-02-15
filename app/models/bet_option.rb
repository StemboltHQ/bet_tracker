class BetOption < ApplicationRecord
  has_many :users, through: :user_bets
  has_many :user_bets

  scope :winners, -> { where(winner: true) }
  scope :losers, -> { where(winner: false) }
end
