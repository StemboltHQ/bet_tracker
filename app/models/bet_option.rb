class BetOption < ApplicationRecord
  has_many :users, through: :user_bets
  has_many :user_bets
  belongs_to :bet

  scope :winners, -> { where(winner: true) }
  scope :losers, -> { where(winner: false) }

  def option_total
    user_bets.pluck(:amount_bet).sum
  end
end
