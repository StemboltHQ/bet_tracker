class Bet < ApplicationRecord
  has_many :users, through: :user_bets
  has_many :user_bets
  has_many :options, through: :user_bets, source: :bet_option

  def winner_total
    @winner_total ||= user_bets.winners.map(&:amount_bet).sum
  end
end
