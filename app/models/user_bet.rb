class UserBet < ApplicationRecord
  belongs_to :user
  belongs_to :bet
  belongs_to :bet_option

  scope :winners, -> { joins(:user, :bet_option).merge(BetOption.winners) }
  scope :losers, -> { joins(:user, :bet_option).merge(BetOption.losers) }
end
